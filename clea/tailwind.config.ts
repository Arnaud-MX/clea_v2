import type { Config } from 'tailwindcss'

const config: Config = {
  content: [
    './app/**/*.{js,ts,jsx,tsx,mdx}',
    './components/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    extend: {
      colors: {
        primary: '#1E88E5',
        primaryLight: '#E3F2FD',
        blueSoft: '#EAF5FF',
        surface: '#FFFFFF',
        bg: '#F7F9FC',
        text: '#0F172A',
      },
      borderRadius: {
        'xl': '16px',
      },
      boxShadow: {
        soft: '0 10px 30px rgba(30, 136, 229, 0.12)',
        card: '0 12px 24px rgba(15, 23, 42, 0.06)',
        button: '0 12px 24px rgba(30, 136, 229, 0.24)',
      },
      keyframes: {
        'fade-up': {
          '0%': { opacity: '0', transform: 'translateY(12px)' },
          '100%': { opacity: '1', transform: 'translateY(0)' },
        },
        pulseSoft: {
          '0%, 100%': { boxShadow: '0 0 0 0 rgba(30, 136, 229, 0.25)' },
          '50%': { boxShadow: '0 0 0 8px rgba(30, 136, 229, 0.0)' },
        },
      },
      animation: {
        'fade-up': 'fade-up 700ms ease-out both',
        'pulse-soft': 'pulseSoft 2.5s ease-in-out infinite',
      },
      fontSize: {
        body: ['16px', { lineHeight: '1.6' }],
        subtitle: ['18px', { lineHeight: '1.5' }],
      },
    },
  },
  plugins: [],
}
export default config