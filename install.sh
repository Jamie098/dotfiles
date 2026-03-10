#!/bin/bash

# Exit on error
set -e

SRCDIR="$HOME/.local/src"
GITHUB="https://github.com/Jamie098"

mkdir -p "$SRCDIR"

# Install pacman packages
sudo pacman -S --needed - < packages/pacman.txt

# Install yay
git clone https://aur.archlinux.org/yay.git "$SRCDIR/yay"
cd "$SRCDIR/yay" && makepkg -si --noconfirm
cd -

# Install yay packages
yay -S --needed - < packages/yay.txt

# Get suckless components
for repo in dwl; do
	git clone "$GITHUB/$repo.git" "$SRCDIR/$repo"
	cd "$SRCDIR/$repo" && sudo make install
	cd -
done

# Get dotfiles
cd "$SRCDIR/dotfiles" && stow --target="$HOME" .

# Setup ssh key
read -p "Email for ssh-keygen" email
ssh-keygen -t ed25519 -C "$email"

# Install ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Install complete"
