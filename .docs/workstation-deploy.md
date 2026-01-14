# Workstation Deployment


Disk configuration overview

```
NAME                 |  SIZE  | TYPE  | MOUNTPOINT |
-------------------  |--------|-------|------------|
nvme0n1              | 465.8G | disk  |            |
├─nvme0n1p1          |     1M | part  | bios boot  |
├─nvme0n1p2          |   550M | part  | /efi       |
├─nvme0n1p3          | 465.2G | part  |            |
..└─lvm              | 465.2G | crypt |            |
....├─matrix-swap    |     8G | lvm   | [SWAP]     |
....├─matrix-system  |    50G | lvm   | /          |
....└─matrix-home    | 425.2G | lvm   | /home      |
```


Setup LUKS and volumes

```
cryptsetup luksFormat --type luks1 --use-random -S 1 -s 512 -h sha512 -i 5000 /dev/nvme0n1p3
cryptsetup luksOpen /dev/nvme0n1p3 lvm
pvcreate /dev/mapper/lvm
vgcreate matrix /dev/mapper/lvm
lvcreate -L 50G matrix -n system
lvcreate -L 8G matrix -n swap
lvcreate -l 100%FREE matrix -n home
mkfs.ext4 /dev/matrix/system
mkfs.ext4 /dev/matrix/home
mkfs.fat -F32 /dev/nvme0n1p2
mkswap /dev/matrix/swap
```


Assemble filesystem

```
mount /dev/matrix/system /mnt
mkdir /mnt/home /mnt/efi
mount /dev/matrix/home /mnt/home
mount /dev/nvme0n1p2 /mnt/efi
swapon /dev/matrix/swap
```


Install base and chroot into it

```
pacstrap /mnt base base-devel linux-libre linux-libre-firmware mkinitcpio grub lvm2 vim dhcpcd wpa_supplicant efibootmgr efitools openssh git zsh tmux wget networkmanager cronie ntp
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
```


Configure system core

```
ln -sf /usr/share/zoneinfo/Europe/Lisbon /etc/localtime
hwclock --systohc
sed -i '/en_US.UTF-8/s/^#//g' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "KEYMAP=us" > /etc/vconsole.conf
echo leetmachine > /etc/hostname
passwd
```


Provision LUKS keyfile

```
mkdir /root/secrets
chmod 700 /root/secrets
head -c 64 /dev/urandom > /root/secrets/crypto_keyfile.bin
chmod 600 /root/secrets/crypto_keyfile.bin
cryptsetup -v luksAddKey -i 1 /dev/nvme0n1p3 /root/secrets/crypto_keyfile.bin
```


Configure and install bootloader and initramfs

```
sed -i 's/^HOOKS=(.*)/HOOKS=(base udev autodetect modconf kms keyboard keymap consolefont block encrypt lvm2 filesystems fsck)/' /etc/mkinitcpio.conf
sed -i 's,^FILES=(.*),FILES=(/root/secrets/crypto_keyfile.bin),' /etc/mkinitcpio.conf
cryptdevice_uuid=$(blkid --output value --match-tag UUID /dev/nvme0n1p3)
sed -i 's/\(^GRUB_CMDLINE_LINUX_DEFAULT=\).*/\1"loglevel=3"/' /etc/default/grub
sed -i "s,\(^GRUB_CMDLINE_LINUX=\).*,\1\"cryptdevice=UUID=${cryptdevice_uuid}:lvm root=/dev/matrix/system cryptkey=rootfs:/root/secrets/crypto_keyfile.bin\"," /etc/default/grub
sed -i '/GRUB_ENABLE_CRYPTODISK/s/^#//g' /etc/default/grub
mkinitcpio -P
grub-install --target=x86_64-efi --efi-directory=/efi
grub-mkconfig -o /boot/grub/grub.cfg
chmod 700 /boot
```

Add user and switch to it

```
sed -i '/%wheel ALL=(ALL:ALL) ALL/s/^#//g' /etc/sudoers
useradd -m -G wheel,audio,video,power -s /usr/bin/zsh grim
passwd grim
passwd -l root
su grim
```


Fetch and install dotfiles

```
git clone --recursive https://github.com/GrimKriegor/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
bash init.sh
cd
zsh
```


List packages

```
export package_list="
# System base
base
base-devel

# Kernel
linux-libre
linux-libre-lts
linux-libre-hardened

# Graphics
## xorg
  xorg-server
  xorg-xev
  xorg-xinit
## xorg-apps
  xorg-xrandr
  xorg-setxkbmap
  xorg-xmodmap
  xorg-xbacklight
## xorg-drivers
  xf86-video-intel
  xf86-video-nouveau
  xf86-video-ati
  xf86-video-amdgpu
  xf86-input-synaptics
xorg-xdpyinfo
xdotool
xorg-xinput
xorg-xkill
xorg-xprop
xorg-xhost
xclip
numlockx

# Desktop
i3-gaps i3lock xautolock i3blocks dunst picom
rofi
feh sxiv
maim
noto-fonts noto-fonts-emoji noto-fonts-cjk
network-manager-applet blueman pasystray
calc

# System utils
openssh sshfs
gnu-netcat
ntp
cronie
alacritty xterm
networkmanager
bluez bluez-utils
vim vim-spell-en vim-spell-pt
tmux
bc
nnn trash-cli
xdg-utils perl-file-mimeinfo
pcmanfm gvfs gvfs-mtp
arandr xsel
rsync
wget
pwgen
ncdu
ripgrep
fd
sysstat
syncthing
tinc
net-tools
acpi
parallel
wol
smartmontools
ethtool wol-systemd

# System extra
powerline powerline-fonts
gtk-engine-murrine papirus-icon-theme lxappearance
#qt5ct qt5-styleplugins
exfat-utils ntfs-3g dosfstools

# System administration
sudo
encfs
htop
less
stress
nethogs
libvirt qemu virt-manager ebtables dnsmasq
podman
pass gnome-keyring
barrier

# Multimedia
ffmpeg
mpv
libva lib32-libva libva-intel-driver lib32-libva-intel-driver lib32-libcanberra libva-mesa-driver lib32-libva-mesa-driver
mpd mpc ncmpcpp
mupdf zathura-djvu zathura-pdf-mupdf zathura-ps zathura-cb
pcmanfm ffmpegthumbnailer
#pulseaudio pulsemixer paprefs pulseaudio-alsa pavucontrol alsa-utils pulseaudio-bluetooth
pipewire pipewire-alsa pipewire-pulse pipewire-jack pavucontrol ncpamixer alsa-utils pamixer
unzip p7zip unrar
yt-dlp
vinagre
soundconverter

# Internet
gnupg
iceweasel
neomutt mutt-wizard lynx
khal todoman khard vdirsyncer
gajim
transmission-remote-gtk stig
arp-scan
bind
newsboat
stig transmission-gtk

# Productivity
xsane simple-scan sane-airscan cups system-config-printer
gnucash
libreoffice-still

# Graphics
gimp
inkscape
#blender
#freecad
imagemagick
prusa-slicer
libjxl

# Music
qjackctl
guitarix2
audacity

# Development
base-devel
git
go
python
jdk-openjdk
android-sdk

# Fonts
otf-font-awesome ttf-dejavu ttf-liberation powerline-fonts
"
```

Install packages

```
sed -i -e '/#\[multilib\]/,+1s/^#//' /etc/pacman.conf
wget https://aur.archlinux.org/cgit/aur.git/snapshot/paru.tar.gz
tar xzf paru.tar.gz
cd paru
makepkg -Ci --syncdeps
rm -rf paru.tar.gz paru/
package_list=$(echo "$package_list" | grep -o '^[^#]*' | tr "\n" " ")
paru -S --needed $(echo ${package_list})
```


Final system tweaks

```
echo -n > /etc/motd
ln -s /dev/null /etc/udev/rules.d/80-net-setup-link.rules

sudo bash -c "cat >> /etc/sysctl.conf" <<EOF
vm.swappiness = 10
fs.inotify.max_user_watches=204800
EOF

# Disable joystick mouse control
sudo mkdir -p /etc/X11/xorg.conf.d
sudo bash -c "cat >> /etc/X11/xorg.conf.d/51-joystick.conf" <<EOF
Section "InputClass"
        Identifier "joystick catchall"
        MatchIsJoystick "on"
        MatchDevicePath "/dev/input/event*"
        Driver "joystick"
        Option "StartKeysEnabled" "False"       #Disable mouse
        Option "StartMouseEnabled" "False"      #support
EndSection
EOF

# Autologin on tty1
sudo mkdir -p /etc/systemd/system/getty@tty1.service.d/
sudo bash -c "cat >> /etc/systemd/system/getty@tty1.service.d/autologin.conf" <<EOF
[Service]
ExecStart=
ExecStart=-/sbin/agetty -o '-p -f -- \\u' --noclear --autologin grim %I $TERM
EOF
sudo systemctl enable getty@tty1

# Disable nouveau
sudo bash -c "cat >> /etc/modprobe.d/blacklist-nouveau.conf" <<EOF
blacklist nouveau
options nouveau modeset=0
EOF

# Enable services
systemctl enable sshd
systemctl enable NetworkManager
systemctl enable cronie
systemctl enable ntpd
systemctl enable bluetooth
systemctl enable wol@eth0
```
