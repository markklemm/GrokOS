qemu-system-x86_64 \
  -m 512M \
  -kernel /boot/vmlinuz-$(uname -r) \
  -append "root=/dev/sda rw console=ttyS0" \
  -hda output/images/rootfs.ext4 \
  -nographic