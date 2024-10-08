# Dotfiles by Chezmoi

-- for Arch Linux

## 0. Choose five mirrors in china for Arch Linux(only for Chinese Archer)

```bash
curl -s "https://archlinux.org/mirrorlist/?country=CN&protocol=https&use_mirror_status=on" | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -n 5 -
```

## 1. Install some packages

```bash
sudo pacman -S git chezmoi fastfetch
```

## 2. Install Paru or Yay

```bash
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
```

```bash
sudo pacman -Sy --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

## 3. Install needed packages

```bash
paru -S zsh oh-my-zsh-git zoxide fzf bat eza starship nvm fd ripgrep neovim-nightly-bin github-cli
```

## 4. Set ZSH as default shell

```bash
chsh -s /usr/bin/zsh
```

## 5. Chezmoi init

Please run the init code twice for toml file and create .dotfiles directory in home

```bash
chezmoi init --apply --verbose https://github.com/jenkinpan/dotfiles.git
```

And then you can delete the ~/.local/share/chezmoi folder

```bash
rm -rf ~/.local/share/chezmoi
```

## 6. Install zsh plugins

```bash
sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
sudo git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
sudo git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete
```
