#!/bin/bash

# 指定目录
dir_path="/"

# 输出文件
output_file=$1

# 清空输出文件
> $output_file

# 遍历目录下的所有文件和子目录
function traverse() {
    local path="$1"
    local indent="$2"

    # 获取当前目录下的所有文件和子目录
    for item in "$path"/*; do
        # 如果是目录，则递归遍历
        if [ -d "$item" ]; then
            echo "${indent}├── $(basename "$item")" >> $output_file
            traverse "$item" "    $indent"
        # 如果是文件，则计算大小并输出
        elif [ -f "$item" ]; then
            size=$(du -sh "$item" | cut -f1)
            echo "${indent}├── $(basename "$item") ($size)" >> $output_file
        fi
    done
}

# 从根目录开始遍历
traverse "$dir_path" ""

# 打印生成的树状图文本文件
cat $output_file