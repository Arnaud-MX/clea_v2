import type { Metadata } from 'next'
import './globals.css'
import { Inter } from 'next/font/google'

const inter = Inter({ subsets: ['latin'] })

export const metadata: Metadata = {
  title: 'Cléa — Découvre ton rang patrimonial en 2 minutes',
  description:
    "Compare ta situation financière avec celle des Français de ton âge et reçois des conseils personnalisés par notre IA.",
  openGraph: {
    title: 'Cléa — Découvre ton rang patrimonial en 2 minutes',
    description:
      "Compare ta situation financière avec celle des Français de ton âge et reçois des conseils personnalisés par notre IA.",
    url: 'https://example.com',
    siteName: 'Cléa',
    images: [
      { url: '/favicon.ico', width: 256, height: 256, alt: 'Cléa' },
    ],
    locale: 'fr_FR',
    type: 'website',
  },
  icons: {
    icon: '/favicon.ico',
  },
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="fr" className="scroll-smooth">
      <body className={`${inter.className} antialiased`}>{children}</body>
    </html>
  )
}
