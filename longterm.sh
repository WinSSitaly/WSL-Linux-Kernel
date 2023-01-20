#!/bin/bash
DIRWSL="/mnt/c/wslconfig"
DIR="$PWD"
DIRgh=$DIR/ciao

if [ -d "$DIRWSL" ]; then
echo $DIRWSL exist
else
mkdir $DIRWSL
fi
cd $DIR
wget https://github.com/WinSSitaly/WSL-Linux-Kernel/raw/main/.wslconfig -O .wslconfig
#wget https://github.com/WinSSitaly/WSL-Linux-Kernel/.wslconfig
cp .wslconfig /mnt/c/wslconfig/.wslconfig
read -p "Enter version number :  " version
if [ -f "/mnt/c/wslconfig/bzImage-test" ]; then
mv /mnt/c/wslconfig/bzImage-test /mnt/c/wslconfig/bzImage_pre-$version
else
echo "bzImage-test not exist"
fi

echo "Compiling longterm version linux-$version!"
wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-$version.tar.xz
tar -xf linux-$version.tar.xz
wget https://github.com/WinSSitaly/WSL-Linux-Kernel/raw/main/mywsl-configlt -O .config

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
			#else
			#	echo $utente con permessi insufficienti
	fi
	done
fi


cd $DIR
cd linux-$version
cp ../.config ./
make clean
make KCONFIG_CONFIG=.config -j128
cp arch/x86/boot/bzImage /mnt/c/wslconfig/bzImage_$version
cp .config ../
cp .config /mnt/c/wslconfig/mywsl-configlt

cp /mnt/c/wslconfig/bzImage_$version /mnt/c/wslconfig/bzImage-test

cp .config /mnt/c/wslconfig/mywsl-configlt
cp .config $DIRgh/WSL-Linux-Kernel/mywsl-configlt

cd $DIRgh/WSL-Linux-Kernel/
make git m="longterm $version"

cd $DIR


