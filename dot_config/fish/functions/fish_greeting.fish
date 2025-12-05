function fish_greeting -d "Display system information after shell initialization"
    # 确保只在交互式 shell 中运行（例如，排除脚本执行）
    if status --is-interactive
        # 运行 fastfetch，使用您配置中的确切参数
        if type -q fastfetch
            fastfetch -l arch --config examples/13
        end
    end
end
