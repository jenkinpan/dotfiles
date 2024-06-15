# dotfiles

## 0. choose five mirrors in china for archlinux

```bash
curl -s "https://archlinux.org/mirrorlist/?country=CN&protocol=https&use_mirror_status=on" | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -n 5 -
```

## 1. Install some packages

```bash
sudo pacman -S git chezmoi
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
paru -S zsh oh-my-zsh-git zoxide fzf bat eza zsh-theme-powerlevel10k nvm fd
```

## 4. Set ZSH as default shell

```bash
chsh -s /usr/bin/zsh
```

## 5. Install zsh plugins

```bash
sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
sudo git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
sudo git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete
```

## 6. Install bat theme

```bash
mkdir -p "$(bat --config-dir)/themes"
cd "$(bat --config-dir)/themes"
curl -O https://raw.githubusercontent.com/folke/tokyonight.nvim/main/extras/sublime/tokyonight_night.tmTheme
bat cache --build
```

## 7. Chezmoi init
Please do this twice for toml file and recreate .dotfiles directory
```bash
chezmoi init --apply --verbose https://github.com/jenkinpan/dotfiles.git
```
