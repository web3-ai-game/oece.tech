#!/bin/bash
# OECE.TECH 部署脚本

echo "🚀 开始部署..."

cd /home/nomad/oece.tech

# 1. 构建
echo "📦 构建应用..."
npm run build

# 2. 复制静态文件
echo "📂 复制静态文件..."
cp -r .next/static .next/standalone/.next/
cp -r public .next/standalone/ 2>/dev/null || true
cp .env .next/standalone/

# 3. 重启PM2
echo "🔄 重启服务..."
pm2 restart oece-web

# 4. 检查状态
sleep 3
pm2 list

echo "✅ 部署完成！"
echo "�� 访问: https://oece.tech"
