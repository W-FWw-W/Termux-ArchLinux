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
apt install proot procps pv wget curl aria2 vim openssh git zsh
#安装依赖
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#安装ZSH
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
#
sed -i 's:ZSH_THEME="robbyrussell":ZSH_THEME="powerlevel10k/powerlevel10k":' .zshrc
# 更改Zsh主题 themes --> ZSH_THEME="powerlevel10k/powerlevel10k"

#创建必要文件夹，防止挂载失败
mkdir Arch-rootfs
mkdir Arch-binds
wget https://mirror.tuna.tsinghua.edu.cn/lxc-images/images/archlinux/current/arm64/default/20200313_04%3A18/rootfs.tar.xz
proot --link2symlink tar -pJx rootfs.tar.xz -C Arch-rootfs
wget https://github.com/W-FWw-W/Termux-ArchLinux/raw/master/start-archlinux.sh
chmod +x start-archlinux.sh

rm -rf Arch/etc/resolv.conf
echo -e "nameserver 8.8.8.8\nnameserver 240c::6666" > Arch-rootfs/etc/resolv.conf
sed -i -e '1i Server = http://mirrors.tuna.tsinghua.edu.cn/archlinuxarm/$arch/$repo' Arch-rootfs/etc/pacman.d/mirrorlist
sed -i 's/#Color/Color/g' Arch-rootfs/etc/pacman.conf

