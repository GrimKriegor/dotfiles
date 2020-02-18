#!/bin/bash

set -e
shopt -s dotglob

# Configurable
installation_directory="$HOME"
blacklist=( "*" "." ".." ".git" ".gitmodules" ".gitignore" "init.sh" ".config" ".local" "README.md" "LICENSE.md" )

# Where is this script located?
dirname="$(cd "$(dirname "$0")"; pwd -P)"

# Some debug information
echo -e "DotFiles directory is $dirname\nInstallation directory is $installation_directory"


#
# Create symlinks for all files and folders in subdir
#
# Usage:
# createLinks <subdirectory> <target subdirectory> <prefix for target files>
#
function createLinks {

  subdir="$1"
  target="$2"
  prefix="$3"

  # Avoid double / when subdir is base folder
  if [ "$subdir" == "" ]; then
    echo -e "\nSubdirectory is the base of DotFiles"
  else
    subdir="$subdir/"
    echo -e "\nSubdirectory is $subdir"
  fi

  target_subdir="$subdir"

  # If target subdir is set, use it instead of subdir
  if [ "$target" == "base" ]; then
    echo -e "Target subdirectory is the base of DotFiles"
    target_subdir=""
  elif [ "$target" != "" ]; then
    echo -e "Target subdirectory is $target"
    target_subdir="$target"
  fi

  # Create target subdirectory
  mkdir -p "$installation_directory/$target_subdir"

  # Iterate through all the files in subdir
  for file in $dirname/$subdir/*
  do

    filename=$(basename $file)
    target_filename="$filename"

    # If prefix is set, concat it with filename
    if [ "$prefix" != "" ]; then
      target_filename="$prefix$filename"
    fi

    # Ignore if blacklisted
    is_blacklisted=""
    for entry in "${blacklist[@]}"; do
      if [ "$filename" == "$entry" ]; then
	is_blacklisted="true"
      fi
    done

    # Create symlink
    if [ "$is_blacklisted" == "" ]; then
      echo "Linking $filename"
      [[ $force && $filename != "" ]] && rm -rf "$installation_directory/$target_subdir$target_filename" 2>/dev/null | true
      ln -sTf "$dirname/$subdir$filename" "$installation_directory/$target_subdir$target_filename" | true
    fi

  done

}


# Parse arguments
script_args="$@"
while [ $# -ne 0 ]; do
  case $1 in

  # Help text
  -h | --help )
    echo -e "$help_text"
    exit 0
  ;;

  # Forceful installation, remove any files that are in the way of the target symlinks
  -f | --force )
    echo -e "\nForcefully removing original files before creating symlinks"
    force=true
  ;;

  # Avoid symlinking desktop environment init files
  -d | --no-desktop )
    echo -e "\nAvoiding desktop environment init files"
    blacklist=( "${blacklist[@]}" ".xinitrc" )
  ;;

  esac
  shift

done


############################
##     Execute things     ##
############################

# zprezto
createLinks ".zprezto/runcoms" "base" "."

# Config directory
createLinks ".config"

# Local fonts
createLinks ".local/share/fonts" ".local/share/fonts/"

# Mimeapps desktop files
createLinks ".local/share/applications" ".local/share/applications/"

# Base directory
createLinks
