pkg up
#升级
termux-wake-lock
#
termux-setup-storage
#读取sdcard
rm -rf $PREFIX/etc/motd
#
pkg install x11-repo
#安装依赖
apt install -y proot vim openssh wget git
#安装依赖

curl -o rootfs.tar.xz https://mirror.tuna.tsinghua.edu.cn/lxc-images/images/archlinux/current/amd64/default/20200312_04%3A18/rootfs.tar.xz
#下载Arch System
mkdir Arch-Rootfs
#建立Arch文件夹
mkdir Arch-binds
#建立Arch-binds文件夹
proot --link2symlink tar -pJvxf rootfs.tar.xz -C Arch-Rootfs
#解压Arch System
unset LD_PRELOAD
#设置初始化

wget https://raw.githubusercontent.com/W-FWw-W/Termux-ArchLinux/master/Proot/start-archlinux.sh

rm -rf Arch-Rootfs/etc/resolv.conf
rm -rf Arch-Rootfs/home/alarm
echo -e "nameserver 8.8.8.8\nnameserver 240c::6666" > Arch-Rootfs/etc/resolv.conf
sed -i -e '1i Server = http://mirrors.tuna.tsinghua.edu.cn/archlinuxarm/$arch/$repo' Arch-Rootfs/etc/pacman.d/mirrorlist
echo -e '[archlinuxcn]\nSigLevel = Optional TrustAll\nServer = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch' >> Arch-Rootfs/etc/pacman.conf
sed -i 's/#Color/Color/g' Arch-Rootfs/etc/pacman.conf

vim Arch-Rootfs/etc/locale.gen
#en_US
vim Arch-Rootfs/etc/locale.conf
#LANG=en_US.UTF-8

vim Arch-Rootfs/etc/hosts
#127.0.0.1  localhost
#127.0.1.1  LinuxArm-FWw
#::1  localhost

chmod +x start-archlinux.sh
vim start-archlinux.sh
./start-archlinux.sh


ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

userdel alarm
useradd -m -g users -G wheel fww
## 1000 985
passwd fww
passwd root


pacman-key --init
pacman-key --populate
pacman -Sy
pacman -Syyuu
pacman -S archlinuxcn-keyring
#pacman.conf --SigLevel = Optional TrustAll--
vim ~/.bashrc
#neofetch

pacman -S noto-fonts noto-fonts-cjk noto-fonts-emoji adobe-source-han-sans-cn-fonts
locale-gen

pacman -S base base-devel git go zsh neofetch man-pages-zh_cn tigervnc xfce4 vim sudo lightdm lightdm-gtk-greeter-settings aria2  xfce4-taskmanager 
pacman -S mousepad inkscape vlc gimp engrampa intellij-idea-ultimate-edition codeblocks  geany eclipse-ecj qtcreator
visudo

su - fww

git clone https://aur.archlinux.org/yay.git
sudo pacman -Rn fakeroot
sudo pacman -S fakeroot-tcp
cd yay
makepkg
sudo pacman -U *.pkg.tar.xz

cd ~
mkdir .vnc
vim ~/.vnc/xstartup
##!/bin/sh
#unset SESSION_MANAGER
#unset DBUS_SESSION_BUS_ADDRESS
#exec dbus-launch startxfce4

sudo chmod +x .vnc/xstartup

export DISPLAY=:1
export USER=fww
export HOME=/home/fww


vncserver -geometry 2340x1080 -depth 24 -name ArchLinuxARM :1

#XSDL
export DISPLAY=127.0.0.1:0
export PULSE_SERVER=tcp:127.0.0.1:4712
startxfce4


#sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#安装ZSH
#git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
#
#sed -i 's:ZSH_THEME="robbyrussell":ZSH_THEME="powerlevel10k/powerlevel10k":' .zshrc
# 更改Zsh主题 themes --> ZSH_THEME="powerlevel10k/powerlevel10k"
cd ~

git clone https://github.com/vinceliuice/Qogir-icon-theme.git
git clone https://github.com/vinceliuice/Matcha-gtk-theme.git
