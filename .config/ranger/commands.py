# This is a sample commands.py.  You can add your own commands here.
#
# Please refer to commands_full.py for all the default commands and a complete
# documentation.  Do NOT add them all here, or you may end up with defunct
# commands when upgrading ranger.

# You always need to import ranger.api.commands here to get the Command class:
from ranger.api.commands import *

# A simple command for demonstration purposes follows.
# -----------------------------------------------------------------------------

# You can import any python module as needed.
import os

# Any class that is a subclass of "Command" will be integrated into ranger as a
# command.  Try typing ":my_edit<ENTER>" in ranger!


class my_edit(Command):
    # The so-called doc-string of the class will be visible in the built-in
    # help that is accessible by typing "?c" inside ranger.
    """:my_edit <filename>

    A sample command for demonstration purposes that opens a file in an editor.
    """

    # The execute method is called when you run this command in ranger.
    def execute(self):
        # self.arg(1) is the first (space-separated) argument to the function.
        # This way you can write ":my_edit somefilename<ENTER>".
        if self.arg(1):
            # self.rest(1) contains self.arg(1) and everything that follows
            target_filename = self.rest(1)
        else:
            # self.fm is a ranger.core.filemanager.FileManager object and gives
            # you access to internals of ranger.
            # self.fm.thisfile is a ranger.container.file.File object and is a
            # reference to the currently selected file.
            target_filename = self.fm.thisfile.path

        # This is a generic function to print text in ranger.
        self.fm.notify("Let's edit the file " + target_filename + "!")

        # Using bad=True in fm.notify allows you to print error messages:
        if not os.path.exists(target_filename):
            self.fm.notify("The given file does not exist!", bad=True)
            return

        # This executes a function from ranger.core.acitons, a module with a
        # variety of subroutines that can help you construct commands.
        # Check out the source, or run "pydoc ranger.core.actions" for a list.
        self.fm.edit_file(target_filename)

    # The tab method is called when you press tab, and should return a list of
    # suggestions that the user will tab through.
    # tabnum is 1 for <TAB> and -1 for <S-TAB> by default
    def tab(self, tabnum):
        # This is a generic tab-completion function that iterates through the
        # content of the current directory.
        return self._tab_directory_content()

class shell(Command):
    escape_macros_for_shell = True

    def execute(self):
        if self.arg(1) and self.arg(1)[0] == '-':
            flags = self.arg(1)[1:]
            command = self.rest(2)
        else:
            flags = ''
            command = self.rest(1)

        if command:
            self.fm.execute_command("/usr/bin/bash -c '" + command + "'", flags=flags)

    def tab(self, tabnum):
        from ranger.ext.get_executables import get_executables
        if self.arg(1) and self.arg(1)[0] == '-':
            command = self.rest(2)
        else:
            command = self.rest(1)
        start = self.line[0:len(self.line) - len(command)]

        try:
            position_of_last_space = command.rindex(" ")
        except ValueError:
            return (start + program + ' ' for program
                    in get_executables() if program.startswith(command))
        if position_of_last_space == len(command) - 1:
            selection = self.fm.thistab.get_selection()
            if len(selection) == 1:
                return self.line + selection[0].shell_escaped_basename + ' '
            else:
                return self.line + '%s '
        else:
            before_word, start_of_word = self.line.rsplit(' ', 1)
            return (before_word + ' ' + file.shell_escaped_basename
                    for file in self.fm.thisdir.files or []
                    if file.shell_escaped_basename.startswith(start_of_word))
