sudo apt update
sudo apt install -y build-essential git bc libncurses-dev unzip make gcc g++ curl

git clone https://git.buildroot.org/buildroot
cd buildroot

make menuconfig

cd ..
mkdir GrokOS
cp buildroot/configs/grokos_defconfig GrokOS/
cd GrokOS
git init
git add grokos_defconfig
git commit -m "Add initial GrokOS Buildroot config"
#git remote add origin https://github.com/markklemm/GrokOS.git
git push -u origin main

mkdir -p buildroot/board/grokos/overlay/root
# TODO cp grok_boot.sh buildroot/board/grokos/overlay/root/
chmod +x buildroot/board/grokos/overlay/root/grokos_boot.sh

::sysinit:/root/grokos_boot.sh
cp buildroot/board/grokos/overlay/root/grokos_boot.sh GrokOS/
cd GrokOS
git add grokos_boot.sh
git commit -m "Add GrokOS boot script"
git push

cd buildroot
make grokos_defconfig
make

qemu-system-x86_64 -m 512 -kernel output/images/bzImage -initrd output/images/rootfs.cpio

sudo dd if=output/images/rootfs.ext4 of=/dev/sdX bs=4M status=progress

