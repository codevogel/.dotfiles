# deps: git
sudo pacman -S --noconfirm --needed git base-devel
rm -rf ./yay-bin
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg --noconfirm -si
cd ..
rm -rf yay-bin
