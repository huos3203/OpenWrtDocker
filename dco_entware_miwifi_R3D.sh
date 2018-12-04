#!/bin/sh

unset LD_LIBRARY_PATH
unset LD_PRELOAD

# For  miwifi HD R1D

echo "Info: https://dco.gitee.io/"
echo "Info: For miwifi HD R3D"
echo "Info: Checking for prerequisites and creating folders..."

if [ -d /userdisk/data/opt ]
then
    echo "Warning: Folder /userdisk/data/opt exists!"
else
    mkdir -p /userdisk/data/opt
    mount -o bind /userdisk/data/opt  /opt
fi
# no need to create many folders. entware-opt package creates most
for folder in bin etc lib/opkg tmp var/lock
do
  if [ -d "/opt/$folder" ]
  then
    echo "Warning: Folder /opt/$folder exists!"
    echo "Warning: If something goes wrong please clean /opt folder and try again."
  else
    mkdir -p /opt/$folder
  fi
done

echo "Info: Opkg package manager deployment..."
DLOADER="ld-linux.so.3"
URL=http://bin.entware.net/armv7sf-k3.2/installer
wget $URL/opkg -O /opt/bin/opkg
chmod 755 /opt/bin/opkg
wget $URL/opkg.conf -O /opt/etc/opkg.conf
wget $URL/ld-2.27.so -O /opt/lib/ld-2.27.so
wget $URL/libc-2.27.so -O /opt/lib/libc-2.27.so
wget $URL/libgcc_s.so.1 -O /opt/lib/libgcc_s.so.1
wget $URL/libpthread-2.27.so -O /opt/lib/libpthread-2.27.so
cd /opt/lib
chmod 755 ld-2.27.so
ln -s ld-2.27.so $DLOADER
ln -s libc-2.27.so libc.so.6
ln -s libpthread-2.27.so libpthread.so.0

echo "Info: Basic packages installation..."
/opt/bin/opkg update
/opt/bin/opkg install entware-opt

# Fix for multiuser environment
chmod 777 /opt/tmp

# now try create symlinks - it is a std installation
if [ -f /etc/passwd ]
then
    ln -sf /etc/passwd /opt/etc/passwd
else
    cp /opt/etc/passwd.1 /opt/etc/passwd
fi

if [ -f /etc/group ]
then
    ln -sf /etc/group /opt/etc/group
else
    cp /opt/etc/group.1 /opt/etc/group
fi

if [ -f /etc/shells ]
then
    ln -sf /etc/shells /opt/etc/shells
else
    cp /opt/etc/shells.1 /opt/etc/shells
fi

if [ -f /etc/shadow ]
then
    ln -sf /etc/shadow /opt/etc/shadow
fi

if [ -f /etc/gshadow ]
then
    ln -sf /etc/gshadow /opt/etc/gshadow
fi

if [ -f /etc/localtime ]
then
    ln -sf /etc/localtime /opt/etc/localtime
fi

curl -s -o /etc/init.d/dco.openwrt  https://dco.gitee.io/file/openwrt/dco.openwrt
chmod 777 /etc/init.d/dco.openwrt
/etc/init.d/dco.openwrt enable

curl -s -o /opt/bin/dco.PATH  https://dco.gitee.io/file/openwrt/dco.PATH
chmod 777 /opt/bin/dco.PATH
/opt/bin/dco.PATH

echo "Info: Congratulations!"
echo "Info: If there are no errors above then Entware was successfully initialized."
echo "Info: https://dco.gitee.io/"
echo "Info: Found a Bug? Please report at https://dco.gitee.io/"
echo "Info: Found a bug? Please report at https://entware.net/"

curl -s https://dco.gitee.io/file/openwrt/information.txt | /bin/cat

for i in `seq -w 60 -1 1`
        do
          echo -ne "安装完毕！路由器将在$i秒后重启\r";
          sleep 1;
      done
reboot
