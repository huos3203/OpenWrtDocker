#  编译OpenWrt12.0.9
[ 搭建自己的opkg软件仓库](https://openwrt.io/docs/create-opkg-package-repository/)
[使用Docker编译OpenWrt Package](https://openwrt.io/docs/build-openwrt-package-using-docker/)

### 重置环境 
移除
```
rm -rf /opt/*
```
### 下载安装文件
```
wget http://pkg.entware.net/binaries/armv7/installer/entware_install.sh && chmod +x entware_install_old.sh  && ./entware_install.sh 
```
### 装载环境变量
```
source /opt/etc/profile
```
### 验证opkg
```
$ which opkg
> /opt/opkg  #必须指向/opt目录下的opkg才生效
```
