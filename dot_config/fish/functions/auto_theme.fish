function auto_theme
    # 检测系统主题
    set system_theme (defaults read -g AppleInterfaceStyle 2>/dev/null)
    
    if test "$system_theme" = "Dark"
        # 系统是暗色主题，使用暗色 Fish 主题
        if not test "$fish_theme" = "Catppuccin Mocha"
            fish_config theme choose "Catppuccin Mocha"
        end
    else
        # 系统是亮色主题，使用亮色 Fish 主题
        if not test "$fish_theme" = "Catppuccin Latte"
            fish_config theme choose "Catppuccin Latte"
        end
    end
end
