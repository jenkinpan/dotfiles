function brew
    # 1. 加载 Homebrew 环境变量
    eval "$(/opt/homebrew/bin/brew shellenv)"

    # 2. 移除此函数定义，让 fish 找到真正的 /opt/homebrew/bin/brew
    functions -e brew

    # 3. 重新执行用户的原始命令
    command brew $argv
end
