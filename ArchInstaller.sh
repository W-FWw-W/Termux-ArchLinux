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
curl -o rootfs.tar.xz https://mirror.tuna.tsinghua.edu.cn/lxc-images/images/archlinux/current/amd64/default/20200312_04%3A18/rootfs.tar.xz
#下载Arch System
mkdir Arch
#建立Arch文件夹
mkdir Arch-binds
#建立Arch-binds文件夹
proot --link2symlink tar -pJvxf rootfs.tar.xz -C Arch
#解压Arch System
unset LD_PRELOAD
#设置初始化
rm -rf Arch/etc/resolv.conf
echo -e "nameserver 8.8.8.8\nnameserver 240c::6666" > Arch/etc/resolv.conf
sed -i -e '1i Server = http://mirrors.tuna.tsinghua.edu.cn/archlinuxarm/$arch/$repo' Arch/etc/pacman.d/mirrorlist
sed -i 's/#Color/Color/g' Arch/etc/pacman.conf
wget https://github.com/W-FWw-W/Termux-ArchLinux/raw/master/start-archlinux.sh
chmod +x start-archlinux.sh
Arch
usermod -l fww root
pacman-key --init
pacman-key --populate
pacman -Sy
pacman -Syyuu
pacman -S neofetch
vim ~/.bashrc
#neofetch
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
pacman -S sudo vim neofetch tigervnc
