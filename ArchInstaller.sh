pkg up
#升级
termux-setup-storage
#读取sdcard
rm -rf $PREFIX/etc/motd
pkg install root-repo x11-repo
#安装依赖
apt install -y proot vim nano openssh wget git zsh
#安装依赖
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#安装ZSH
#cd ~
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k/powerlevel10k"/g' .zshrc
# 更改Zsh主题 themes --> ZSH_THEME="powerlevel10k/powerlevel10k"
curl -o rootfs.tar.xz https://mirror.tuna.tsinghua.edu.cn/lxc-images/images/archlinux/current/arm64/default/20200310_04%3A18/rootfs.tar.xz
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

cat > /data/data/com.termux/files/usr/bin/Arch <<-EndOfFile
cd $(dirname $0)
pulseaudio -k >>/dev/null 2>&1
pulseaudio --start >>/dev/null 2>&1
unset LD_PRELOAD
command="proot"
command+=" --link2symlink"
command+=" -0"
command+=" -r Arch"
if [ -n "$(ls -A Arch-binds)" ]; then
for f in Arch-binds/* ;do
. $f
done
fi
command+=" -b /dev"
command+=" -b /proc"
command+=" -b Arch/root:/dev/shm"
command+=" -w /root"
command+=" /usr/bin/env -i"
command+=" HOME=/root"
command+=" PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/games:/usr/local/games"
command+=" TERM=$TERM"
command+=" LANG=en_US.UTF-8"
command+=" LC_ALL=C"
command+=" LANGUAGE=en_US"
command+=" /bin/bash --login"
com="$@"
if [ -z "$1" ];then
exec $command
else
$command -c "$com"
fi
EndOfFile
wget https://github.com/W-FWw-W/Termux-ArchLinux/raw/master/start-archlinux.sh
sed -i 's/#Color/Color/g' Arch/etc/pacman.conf

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

