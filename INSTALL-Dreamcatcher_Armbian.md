## How to install:

1. Back up current working boot environment
   1. ```tar zcf /boot.tgz /boot /lib/modules```
   2.  To recover:
       1. ```rm -rf /boot /lib/modules``` **CAREFUL! Make sure your backup exists!!***
       2. ``tar -xzf /boot.tgz -C /```
2. Download linux-image deb (and optionally linux-headers deb)
3. Download DTB file
4. [_**Only if you installed previous versions of my kernel**_] Remove current modules
    1. ```sudo rm -rf /lib/modules/4.19.30-dc3/```
    2. _**DO NOT REBOOT UNTIL YOU FINISH INSTALLING THE UPDATE**_
5. Install DTB into /boot/dtb
    1. ```sudo cp /boot/dtb/sun5i-a13-dreamcatcher.dtb /boot/dtb/sun5i-a13-dreamcatcher.dtb.backup```
    2. ```sudo mv sun5i-a13-dreamcatcher.dtb /boot/dtb/sun5i-a13-dreamcatcher.dtb```
6. Install deb files (```sudo dpkg -i linux*dc3*.deb```)
7. Verify symlinks point to new kernel
    1. ```cd /boot && rm zImage && ln -s vmlinuz-4.19.30-dc3+ zImage```
    2. ```cd /boot && rm uInitrd && ln -s uInitrd-4.19.30-dc3+ uInitrd```
8. Reboot into new kernel
