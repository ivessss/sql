#!/bin/bash

# 数据库登录信息
DB_USER="root"          # 替换为你的数据库用户名
DB_PASSWORD="abcABC!@#123"  # 替换为你的数据库密码
DB_HOST="124.222.26.224"             # 替换为你的数据库主机名

# 数据文件的根目录
SQL_DIR="/train_sql"  # 替换为你实际的路径
#SQL_DIR="/dev_sql"
# 遍历每个文件夹
for db_dir in "$SQL_DIR"/*; do
    if [ -d "$db_dir" ]; then
        # 提取数据库名称（文件夹名称）
        db_name=$(basename "$db_dir")
        
        echo "正在创建数据库：$db_name"
        mysql -u $DB_USER -p$DB_PASSWORD -h $DB_HOST -e "CREATE DATABASE IF NOT EXISTS $db_name;"
        
        # 遍历每个.sql文件
        for sql_file in "$db_dir"/*.sql; do
            if [ -f "$sql_file" ]; then
                echo "正在导入 $sql_file 到数据库 $db_name"
                mysql -u $DB_USER -p$DB_PASSWORD -h $DB_HOST $db_name < "$sql_file"
            fi
        done
    fi
done

echo "所有数据库和表已导入完成！"
