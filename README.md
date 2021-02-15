# WSL-Linux-Kernel
My Experiment on WSL Linux Kernel

#!/bin/bash</br>
read -p "Input version number :  " version</br>
echo "Compile my version linux-$version!"
mv /mnt/c/Users/<username>/bzImage-test /mnt/c/Users/<username>/bzImage_pre-$versione
#last version=5.11-rc7

#git clone https://github.com/microsoft/WSL2-Linux-Kernel
git clone https://github.com/nathanchance/WSL2-Linux-Kernel
wget https://git.kernel.org/torvalds/t/linux-$versione.tar.gz
tar -xzvf linux-$version.tar.gz
cd linux-$version
cp ../WSL2-Linux-Kernel/.config ./
make clean
make KCONFIG_CONFIG=.config -j8
#ready to copy to windows path
#cp arch/x86/boot/bzImage /mnt/c/Users/<username>/bzImage_$versione
#cp /mnt/c/Users/tecnico/bzImage_$versione /mnt/c/Users/<username>/bzImage-test

#you must change <username> with your windows user
#and of course you must create if not exist a file .wslconfig with kernel = c:\\users\\<username>\\bzImage_5.11-rc7
