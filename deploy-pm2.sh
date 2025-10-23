#!/bin/bash

# PM2部署脚本 - 替代Docker方案
# 适用于低配VPS (1vCPU/2GB)

set -e

echo "🚀 开始PM2部署流程..."

# 检查PM2是否安装
if ! command -v pm2 &> /dev/null; then
    echo "❌ PM2未安装，正在安装..."
    npm install -g pm2
fi

# 创建logs目录
mkdir -p logs

# 拉取最新代码
echo "📥 拉取最新代码..."
git pull origin main

# 安装依赖
echo "📦 安装依赖..."
npm ci --production=false

# 构建静态站点
echo "🔨 构建静态站点..."
npm run build

# 检查构建产物
if [ ! -d "out" ]; then
    echo "❌ 构建失败：out目录不存在"
    exit 1
fi

# 重启PM2服务
echo "🔄 重启PM2服务..."
pm2 reload ecosystem.config.js || pm2 start ecosystem.config.js

# 保存PM2配置
pm2 save

echo "✅ 部署完成！"

# 显示状态
echo ""
echo "📊 PM2状态："
pm2 list

echo ""
echo "💾 内存使用："
free -h

echo ""
echo "📁 磁盘使用："
df -h /

echo ""
echo "🌐 访问: http://localhost:3000"
