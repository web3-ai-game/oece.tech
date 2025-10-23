import type { Metadata } from 'next'
import './globals.css'

export const metadata: Metadata = {
  title: 'OECE.TECH | Digital Nomad Dev Journal',
  description: 'A tech blog about coding while traveling the world - tutorials, stories, and experiences from a digital nomad developer',
  keywords: 'digital nomad, developer, travel, coding, tutorials',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="zh-TW">
      <body>{children}</body>
    </html>
  )
}
