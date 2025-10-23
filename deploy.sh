#!/bin/bash

# OECE.TECH 部署腳本
# 用於在 VPS 上快速部署和更新

set -e

echo "🚀 OECE.TECH 部署腳本"
echo "===================="

# 顏色定義
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 檢查 Docker 是否安裝
if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Docker 未安裝，請先安裝 Docker${NC}"
    exit 1
fi

# 檢查 Docker Compose 是否安裝
if ! command -v docker-compose &> /dev/null; then
    echo -e "${RED}❌ Docker Compose 未安裝，請先安裝 Docker Compose${NC}"
    exit 1
fi

# 檢查 .env 文件
if [ ! -f .env ]; then
    echo -e "${YELLOW}⚠️  未找到 .env 文件，從 .env.example 創建${NC}"
    cp .env.example .env
    echo -e "${YELLOW}請編輯 .env 文件並添加必要的配置！${NC}"
    exit 1
fi

echo ""
echo "📥 拉取最新代碼..."
git pull origin main

echo ""
echo "🛑 停止現有容器..."
docker-compose down

echo ""
echo "🔨 構建新鏡像..."
docker-compose build

echo ""
echo "🚀 啟動服務..."
docker-compose up -d

echo ""
echo "⏳ 等待服務啟動..."
sleep 5

echo ""
echo "📊 服務狀態："
docker-compose ps

echo ""
echo "🧹 清理舊鏡像..."
docker image prune -f

echo ""
echo "💾 內存使用情況："
free -h

echo ""
echo -e "${GREEN}✅ 部署完成！${NC}"
echo ""
echo "常用命令："
echo "  查看日誌: docker-compose logs -f"
echo "  停止服務: docker-compose down"
echo "  重啟服務: docker-compose restart"
echo "  查看狀態: docker-compose ps"
echo ""
