# WSL-Linux-Kernel
My Experiment on WSL Linux Kernel

#!/bin/bash</br>
read -p "Input version number :  " version</br>
echo "Compile my version linux-$version!"</br>
mv /mnt/c/Users/username/bzImage-test /mnt/c/Users/username/bzImage_pre-$version</br>
#last version=5.11-rc7</br>
</br>
#git clone https://github.com/microsoft/WSL2-Linux-Kernel</br>
git clone https://github.com/nathanchance/WSL2-Linux-Kernel</br>
wget https://git.kernel.org/torvalds/t/linux-$versione.tar.gz</br>
tar -xzvf linux-$version.tar.gz</br>
cd linux-$version</br>
cp ../WSL2-Linux-Kernel/.config ./</br>
make clean</br>
make KCONFIG_CONFIG=.config -j8</br>
#ready to copy to windows path</br>
#cp arch/x86/boot/bzImage /mnt/c/Users/username/bzImage_$version</br>
#cp /mnt/c/Users/username/bzImage_$version /mnt/c/Users/username/bzImage-test</br>
</br>
#you must change username with your windows user</br>
#and of course you must create if not exist a file .wslconfig with kernel = c:\\users\\username\\bzImage_5.11-rc7</br>
#2021 02 16 UTC+1 
