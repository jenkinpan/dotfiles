function auto_theme
    # detect system theme(macos only)
    if defaults read -g AppleInterfaceStyle 2>/dev/null | grep -q Dark
        # when system in dark mode, use dark Fish theme, fzf theme and btop theme
        if not test "$fish_theme" = "Catppuccin Mocha"
            fish_config theme choose "Catppuccin Mocha"
            source ~/.config/fish/themes/fzf/catppuccin-fzf-mocha.fish
        end

        # set btop theme to mocha
        set btop_config ~/.config/btop/btop.conf
        if test -f "$btop_config"
            sed -i '' 's|color_theme = .*|color_theme = "/Users/jenkin/.config/btop/themes/catppuccin_mocha.theme"|' "$btop_config"
        end
    else
        # when system in light mode, use light Fish theme, fzf theme and btop theme
        if not test "$fish_theme" = "Catppuccin Latte"
            fish_config theme choose "Catppuccin Latte"
            source ~/.config/fish/themes/fzf/catppuccin-fzf-latte.fish
        end

        # set btop theme to latte
        set btop_config ~/.config/btop/btop.conf
        if test -f "$btop_config"
            sed -i '' 's|color_theme = .*|color_theme = "/Users/jenkin/.config/btop/themes/catppuccin_latte.theme"|' "$btop_config"
        end
    end
end
