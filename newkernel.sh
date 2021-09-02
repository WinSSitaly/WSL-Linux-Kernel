#!/bin/bash
DIRWSL="/mnt/c/wslconfig"
DIR="$PWD"
if [ -d "$DIRWSL" ]; then
echo $DIRWSL exist
else
mkdir $DIRWSL
fi
cd $DIR
wget https://github.com/WinSSitaly/WSL-Linux-Kernel/raw/main/.wslconfig -O .wslconfig
cp .wslconfig /mnt/c/wslconfig/.wslconfig
read -p "Enter version number :  " version
if [ -f "/mnt/c/wslconfig/bzImage-test" ]; then
mv /mnt/c/wslconfig/bzImage-test /mnt/c/wslconfig/bzImage_pre-$version
else
echo "no yet any bzImage-test"
fi

#version=5.13.13
#if you want to download the official microsoft wsl2 tree
#git clone https://github.com/microsoft/WSL2-Linux-Kernel

if [[ $version == *"rc"* ]]; then
echo "Compiling release candidate linux-$version!"
wget https://git.kernel.org/torvalds/t/linux-$version.tar.gz
tar -xzvf linux-$version.tar.gz
wget https://github.com/WinSSitaly/WSL-Linux-Kernel/raw/main/mywsl-configrc -O .config
else
echo "Compiling stable version linux-$version!"
wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-$version.tar.xz
tar -xf linux-$version.tar.xz
wget https://github.com/WinSSitaly/WSL-Linux-Kernel/raw/main/mywsl-config -O .config
fi

searchDir="/mnt/c/Users/"
Users=()
while IFS= read -r -d $'\0' activeuser; do
    Users+=("$activeuser")
done < <(find "$searchDir" -maxdepth 1 -type d -print0 2> /dev/null)

if [[ ${#Users[@]} -ne 0 ]]; then
    for user in "${Users[@]}"; do
    if [ "$(stat -c '%a' $user)" == "777" ]
			then
				cp .wslconfig $user/.wslconfig
				echo copying .wslconfig in $user
			#else
			#	echo no $user has not enough right 
	fi
	done
fi
cd $DIR
cd linux-$version
cp ../.config ./
make clean
make KCONFIG_CONFIG=.config -j8
cp arch/x86/boot/bzImage /mnt/c/wslconfig/bzImage_$version
cp .config ../
cp /mnt/c/wslconfig/bzImage_$version /mnt/c/wslconfig/bzImage-test
cd $DIR
