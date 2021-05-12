#!/bin/bash
DIRWSL="/mnt/c/wslconfig"
DIR="$PWD"
if [ -d "$DIRWSL" ]; then
echo $DIRWSL esiste
else
mkdir $DIRWSL
fi
cd $DIR
wget https://github.com/WinSSitaly/WSL-Linux-Kernel/raw/main/.wslconfig
#wget https://github.com/WinSSitaly/WSL-Linux-Kernel/.wslconfig
cp .wslconfig /mnt/c/wslconfig/.wslconfig
read -p "Enter version number :  " versione
if [ -f "/mnt/c/wslconfig/bzImage-test" ]; then
mv /mnt/c/wslconfig/bzImage-test /mnt/c/wslconfig/bzImage_pre-$versione
else
echo "non esiste bzImage-test"
fi

#versione=5.12_latest
#scarica official wsl2
#git clone https://github.com/microsoft/WSL2-Linux-Kernel
#git clone https://github.com/nathanchance/WSL2-Linux-Kernel

if [[ $versione == *"rc"* ]]; then
echo "Compilo la versione release candidate linux-$versione!"
#wget https://git.kernel.org/torvalds/t/linux-$versione.tar.gz
#tar -xzvf linux-$versione.tar.gz
cp $DIR/WSL2-Linux-Kernel/.configrc $DIR/linux-$versione/.config
else
echo "Compilo la versione stabile linux-$versione!"
wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-$versione.tar.xz
tar -xf linux-$versione.tar.xz
cp $DIR/WSL2-Linux-Kernel/.config $DIR/linux-$versione/
fi

searchDir="/mnt/c/Users/"
Utenti=()
while IFS= read -r -d $'\0' utentetrovato; do
    Utenti+=("$utentetrovato")
done < <(find "$searchDir" -maxdepth 1 -type d -print0 2> /dev/null)

if [[ ${#Utenti[@]} -ne 0 ]]; then
    for utente in "${Utenti[@]}"; do
    cp .wslconfig $utente/.wslconfig 
    #echo $utente
    done
fi
cd $DIR
cd linux-$versione
rm cp ../WSL2-Linux-Kernel/.config ./
make clean
make KCONFIG_CONFIG=.config -j8
cp arch/x86/boot/bzImage /mnt/c/wslconfig/bzImage_$versione
cp /mnt/c/wslconfig/bzImage_$versione /mnt/c/wslconfig/bzImage-test
cd $DIR
