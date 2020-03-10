curl -o rootfs.tar.xz https://mirrors.tuna.tsinghua.edu.cn/lxc-images/images/archlinux/current/arm64/default/20200308_04%3A18/rootfs.tar.xz
mkdir Arch
mkdir Arch-binds
proot --link2symlink tar -pJvxf rootfs.tar.xz -C Arch
unset LD_PRELOAD
rm -rf Arch/etc/resolv.conf
echo -e "nameserver 8.8.8.8\nnameserver 240c::6666" > Arch/etc/resolv.conf
sed -i -e '1i Server = https://mirrors.ustc.edu.cn/archlinuxarm/$arch/$repo' Arch/etc/pacman.d/mirrorlist
curl -o start-archlinux.sh https://raw.githubusercontent.com/W-FWw-W/Termux-ArchLinux/master/start-archlinux.sh
