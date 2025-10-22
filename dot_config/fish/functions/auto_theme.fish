function auto_theme
    # detect system theme
    set system_theme (defaults read -g AppleInterfaceStyle 2>/dev/null)

    if test "$system_theme" = Dark
        # when system in dark mode, use dark Fish theme and fzf theme
        if not test "$fish_theme" = "Catppuccin Mocha"
            fish_config theme choose "Catppuccin Mocha"
            source ~/.config/fish/themes/fzf/catppuccin-fzf-mocha.fish
        end
    else
        # when system in light mode, use light Fish theme and fzf theme
        if not test "$fish_theme" = "Catppuccin Latte"
            fish_config theme choose "Catppuccin Latte"
            source ~/.config/fish/themes/fzf/catppuccin-fzf-latte.fish
        end
    end
end
