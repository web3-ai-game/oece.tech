/** @type {import('next').NextConfig} */
const nextConfig = {
  output: 'export',
  reactStrictMode: true,
  swcMinify: true,
  compress: true,

  // 图片优化 - 静态导出必须禁用
  images: {
    unoptimized: true,
  },

  // 尾部斜杠处理
  trailingSlash: true,
}

module.exports = nextConfig
