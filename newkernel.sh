#!/bin/bash
DIRWSL="/mnt/c/wslconfig"
DIR="$PWD"
DIRgh=$DIR/ciao

if [ -d "$DIRgh" ]; then
echo $DIRgh already exist
else
mkdir $DIRgh
cd ciao
git clone https://github.com/WinSSitaly/WSL-Linux-Kernel
fi

if [ -d "$DIRWSL" ]; then
echo $DIRWSL already exist
else
mkdir $DIRWSL
fi

wget https://github.com/WinSSitaly/WSL-Linux-Kernel/raw/main/.wslconfig -O .wslconfig

cp .wslconfig /mnt/c/wslconfig/.wslconfig
read -p "Enter version number :  " version

pre=${version:0:1}
	if [[ $pre == "5" ]]; then
		post=${version:2:2}
	else
		post=${version:2:1}
	fi
if [ -f "/mnt/c/wslconfig/bzImage-test" ]; then
echo "already exist"
mv /mnt/c/wslconfig/bzImage-test /mnt/c/wslconfig/bzImage_pre-$version
else
echo "not valid bzImage-test"
fi

if [[ $version == *"rc"* ]]; then
echo "Compile release candidate linux-$version!"
wget https://git.kernel.org/torvalds/t/linux-$version.tar.gz
tar -xzvf linux-$version.tar.gz
wget https://github.com/WinSSitaly/WSL-Linux-Kernel/raw/main/mywsl-configrc -O .config
else
echo "Compile stable linux-$version!"
wget https://cdn.kernel.org/pub/linux/kernel/v$pre.x/linux-$version.tar.xz
tar -xf linux-$version.tar.xz
wget https://raw.githubusercontent.com/WinSSitaly/WSL-Linux-Kernel/main/mywsl-config$pre$post -O .config
fi

searchDir="/mnt/c/Users/"
Utenti=()
while IFS= read -r -d $'\0' utentetrovato; do
    Utenti+=("$utentetrovato")
done < <(find "$searchDir" -maxdepth 1 -type d -print0 2> /dev/null)

if [[ ${#Utenti[@]} -ne 0 ]]; then
    for utente in "${Utenti[@]}"; do
    if [ "$(stat -c '%a' $utente)" == "777" ]
			then
				cp .wslconfig $utente/.wslconfig
				echo .wslconfig copiato in $utente
	fi
	done
fi
cd $DIR
cd linux-$version
cp ../.config ./
make clean
make KCONFIG_CONFIG=.config -j32
cp arch/x86/boot/bzImage /mnt/c/wslconfig/bzImage_$version
cp .config ../
if [[ $version == *"rc"* ]]; then
	cp .config /mnt/c/wslconfig/mywsl-configrc
	cp .config $DIRgh/WSL-Linux-Kernel/mywsl-configrc
else
	cp .config /mnt/c/wslconfig/mywsl-config$pre$post
	#cp .config $DIRgh/WSL-Linux-Kernel/mywsl-config$pre$post
	echo $DIRgh
	echo $DIRgh/WSL-Linux-Kernel
fi

cp .config /mnt/c/wslconfig/
cp /mnt/c/wslconfig/bzImage_$version /mnt/c/wslconfig/bzImage-test

cd $DIRgh/WSL-Linux-Kernel/
make git m="stable $version"

cd $DIR
