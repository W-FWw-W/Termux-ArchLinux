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
apt install -y proot vim nano openssh wget git zsh
#安装依赖
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#安装ZSH
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
#
sed -i 's:ZSH_THEME="robbyrussell":ZSH_THEME="powerlevel10k/powerlevel10k":' .zshrc
# 更改Zsh主题 themes --> ZSH_THEME="powerlevel10k/powerlevel10k"
cd ~




#!/data/data/com.termux/files/usr/bin/bash
termux-setup-storage

#安装必要依赖
apt install proot procps pv wget curl aria2

#创建必要文件夹，防止挂载失败
mkdir Arch-rootfs
mkdir Arch-binds
wget https://mirror.tuna.tsinghua.edu.cn/lxc-images/images/archlinux/current/arm64/default/20200313_04%3A18/rootfs.tar.xz
proot --link2symlink tar -pJx rootfs.tar.xz -C Arch-rootfs
wget https://github.com/W-FWw-W/Termux-ArchLinux/raw/master/start-archlinux.sh
