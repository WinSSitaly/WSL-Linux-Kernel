#!/bin/bash
DIRWSL="/mnt/c/wslconfig"
DIR="$PWD"
if [ -d "$DIRWSL" ]; then
echo $DIRWSL esiste
else
mkdir $DIRWSL
fi
cd $DIR
wget https://github.com/WinSSitaly/WSL-Linux-Kernel/raw/main/.wslconfig -O .wslconfig
#wget https://github.com/WinSSitaly/WSL-Linux-Kernel/.wslconfig
cp .wslconfig /mnt/c/wslconfig/.wslconfig
read -p "Enter version number :  " versione

pre=${versione:0:1}
	if [[ $pre == "5" ]]; then
		post=${versione:2:2}
	else
		post=${versione:2:1}
	fi
if [ -f "/mnt/c/wslconfig/bzImage-test" ]; then
echo "esiste"
mv /mnt/c/wslconfig/bzImage-test /mnt/c/wslconfig/bzImage_pre-$versione
else
echo "non esiste bzImage-test"
fi

#versione=5.13_latest
#scarica official wsl2
#git clone https://github.com/microsoft/WSL2-Linux-Kernel
#git clone https://github.com/nathanchance/WSL2-Linux-Kernel

if [[ $versione == *"rc"* ]]; then
echo "Compilo la versione release candidate linux-$versione!"
wget https://git.kernel.org/torvalds/t/linux-$versione.tar.gz
tar -xzvf linux-$versione.tar.gz
wget https://github.com/WinSSitaly/WSL-Linux-Kernel/raw/main/mywsl-configrc -O .config
#cp $DIR/WSL2-Linux-Kernel/.configrc $DIR/linux-$versione/.config
else
echo "Compilo la versione stabile linux-$versione!"
#####wget https://cdn.kernel.org/pub/linux/kernel/v$pre.x/linux-$versione.tar.xz
####tar -xf linux-$versione.tar.xz
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
			#else
				#echo $utente con permessi insufficienti
	fi
	done
#else
#echo "azz"
fi
cd $DIR
cd linux-$versione
cp ../.config ./
make clean
make KCONFIG_CONFIG=.config -j8
cp arch/x86/boot/bzImage /mnt/c/wslconfig/bzImage_$versione
cp .config ../
if [[ $versione == *"rc"* ]]; then
	cp .config /mnt/c/wslconfig/mywsl-configrc
	cp .config ../ciao/WSL-Linux-Kernel/mywsl-configrc
else
		cp .config /mnt/c/wslconfig/mywsl-config$pre$post
		cp .config ../ciao/WSL-Linux-Kernel/mywsl-config$pre$post
fi

cp .config /mnt/c/wslconfig/
cp /mnt/c/wslconfig/bzImage_$versione /mnt/c/wslconfig/bzImage-test

cd $DIR

cd ciao/WSL-Linux-Kernel/
make git m="stable $versione"

cd $DIR
