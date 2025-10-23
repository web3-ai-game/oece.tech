---
trigger: always_on
---

# Deployment Rules via Copilot CLI

## GitHub Actions禁用
VPS配置低, 使用本地构建+rsync

## 部署步骤模板
1. 本地构建: `npm run build`
2. SSH连接: `ssh -i ~/.ssh/do_key user@oece.tech`
3. Rsync同步: `rsync -avz --delete dist/ user@ip:/var/www/oece/`
4. PM2重启: `pm2 reload oece`

## 环境变量管理
- 本地: `.env.local`
- 生产: DO `/var/www/oece/.env`
- 禁止硬编码任何密钥

## 回滚策略
- 保留最近3个版本
- 符号链接切换: `ln -sfn releases/v2 current`