import { hero } from '@/app/data'
import StoreButtons from './StoreButtons'
import PhoneMockup from './PhoneMockup'

export default function Hero() {
  return (
    <section className="relative overflow-hidden">
      {/* Blobs décoratifs */}
      <svg className="pointer-events-none absolute -right-32 -top-24 h-[480px] w-[480px] opacity-30" viewBox="0 0 400 400" aria-hidden="true">
        <defs>
          <linearGradient id="grad1" x1="0" x2="1" y1="0" y2="1">
            <stop offset="0%" stopColor="#55B4FF" stopOpacity="0.35" />
            <stop offset="100%" stopColor="#1E88E5" stopOpacity="0.15" />
          </linearGradient>
        </defs>
        <circle cx="200" cy="200" r="200" fill="url(#grad1)" />
      </svg>

      <div className="mx-auto max-w-7xl px-4 py-16 sm:py-20 md:py-24">
        <div className="grid items-center gap-12 md:grid-cols-2">
          <div className="reveal space-y-6">
            <h1 className="text-balance text-3xl font-semibold text-text sm:text-4xl md:text-5xl" style={{
              fontSize: 'clamp(28px, 5vw, 56px)'
            }}>
              {hero.title}
            </h1>
            <p className="text-[18px] leading-[1.5] text-slate-600 sm:text-[20px]">
              {hero.subtitle}
            </p>
            <div className="pt-2">
              <StoreButtons />
            </div>
          </div>

          <div className="reveal relative mx-auto w-full max-w-sm md:max-w-md">
            <div className="absolute -inset-6 -z-10 rounded-[32px] blur-2xl" style={{ backgroundColor: 'rgba(227,242,253,0.7)' }} aria-hidden="true" />
            <PhoneMockup image={hero.phoneImage} alt="Aperçu de l’application Cléa" />
          </div>
        </div>
      </div>
    </section>
  )
}