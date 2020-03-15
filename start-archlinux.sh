cd $(dirname $0)
pulseaudio -k >>/dev/null 2>&1
pulseaudio --start >>/dev/null 2>&1
unset LD_PRELOAD
command="proot"
command+=" --link2symlink"
command+=" -i 0:0"
command+=" -r Arch-Rootfs"
if [ -n "$(ls -A Arch-binds)" ]; then
for f in Arch-binds/* ;do
. $f
done
fi
command+=" -b /dev"
command+=" -b /proc"
command+=" -b Arch-Rootfs/root:/dev/shm"
command+=" -w /root"
command+=" /usr/bin/env -i"
command+=" HOME=/root"
command+=" PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/games:/usr/local/games"
command+=" TERM=$TERM"
command+=" LANG=zh_CN.UTF-8"
command+=" LC_ALL=C"
command+=" /bin/bash --login"
com="$@"
if [ -z "$1" ];then
exec $command
else
$command -c "$com"
fi
