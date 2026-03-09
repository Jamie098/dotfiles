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
for repo in dwm st dmenu; do
	git clone "$GITHUB/$repo.git" "$SRCDIR/$repo"
	cd "$SRCDIR/$repo" && sudo make install
	cd -
done

# Get dotfiles
git clone "$GITHUB/dotfiles.git" "$SRCDIR/dotfiles"
cd "$SRCDIR/dotfiles" && stow --target="$HOME" .

echo "Done. Manual steps remaining:"
echo "	- Install oh-my-zsh"
echo "	- Set zsh as default shell"

echo "End."
