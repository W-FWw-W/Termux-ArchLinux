#!/data/data/com.termux/files/usr/bin/bash
termux-setup-storage
apt install -y proot vim nano openssh wget
curl -o rootfs.tar.xz https://mirror.tuna.tsinghua.edu.cn/lxc-images/images/archlinux/current/arm64/default/20200310_04%3A18/rootfs.tar.xz
mkdir Arch
mkdir Arch-binds
proot --link2symlink tar -pJvxf rootfs.tar.xz -C Arch
unset LD_PRELOAD
rm -rf Arch/etc/resolv.conf
echo -e "nameserver 8.8.8.8\nnameserver 240c::6666" > Arch/etc/resolv.conf
sed -i -e '1i Server = http://mirrors.tuna.tsinghua.edu.cn/archlinuxarm/$arch/$repo' Arch/etc/pacman.d/mirrorlist
cat >/data/data/com.termux/files/usr/bin/arch <<-EndOfFile
#!/data/data/com.termux/files/usr/bin/bash
cd ~
startarch(){
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
command+=" LANG=zh_CN.UTF-8"
command+=" LC_ALL=C"
command+=" LANGUAGE=en_US"
command+=" /bin/bash --login"
com="$@"
if [ -z "$1" ];then
exec $command
else
$command -c "$com"
fi
}
chmod +x /data/data/com.termux/files/usr/bin/arch

