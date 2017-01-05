printf "The bash commands used can be found individually at https://archlinuxarm.org/platforms/armv7/samsung/samsung-chromebook. \n I just compiled them into one bash script for your convenience. "

RED='\033[0;31m'
NC='\033[0m' # No Color
printf "${RED}WHEN ASKED, PLEASE TYPE G FOLLOWED BY W${NC} \n\n\n\n"

echo "when the menu comes up, submit g then w"
umount /dev/mmcblk1*
fdisk /dev/mmcblk1

cgpt create /dev/mmcblk1
cgpt add -i 1 -t kernel -b 8192 -s 32768 -l Kernel -S 1 -T 5 -P 10 /dev/mmcblk1

cgpt add -i 2 -t data -b 40960 -s `expr 123992031 - 40960` -l Root /dev/mmcblk1


partx -a /dev/mmcblk1
mkfs.ext4 /dev/mmcblk1p2


cd /tmp
wget http://os.archlinuxarm.org/os/ArchLinuxARM-peach-latest.tar.gz
mkdir root
mount /dev/mmcblk1p2 root
tar -xf ArchLinuxARM-peach-latest.tar.gz -C root

echo "Flashing Kernel"

dd if=root/boot/vmlinux.kpart of=/dev/mmcblk1p1

umount root
sync

printf "${RED}SETUP COMPLETED.${NC} \n\n\n\n"
