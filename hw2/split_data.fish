#!/usr/bin/fish

# 设置数据文件路径
set data_file "pubnr_cn.txt"

# 设置基础目录
set base_dir "./output"

# 如果基础目录不存在则创建
mkdir -p $base_dir

# 读取数据文件并分割成每100行的小组
set group_size 100
set -l line_count 0
set -l group_count 0
set -l group_dir

while read -l line
    # 计算行数
    math line_count = $line_count + 1

    # 计算小组数
    math group_count = (math $line_count % $group_size) + 1

    # 创建小组目录
    if test $group_count = 1
        set group_dir "$base_dir/group_{$line_count}"
        mkdir -p $group_dir
    end

    # 写入数据到文件
    echo $line > "$group_dir/file_$group_count.txt"
end < $data_file
