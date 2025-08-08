import Image from 'next/image'
import { screenshots } from '@/app/data'

export default function Screenshots() {
  return (
    <section className="mx-auto max-w-7xl px-4 py-14 sm:py-16 md:py-20">
      <div className="mx-auto max-w-2xl text-center">
        <h2 className="reveal text-2xl font-semibold text-text sm:text-3xl">Aperçus de l’app</h2>
        <p className="reveal mt-3 text-slate-600">Fais défiler quelques écrans clés de Cléa.</p>
      </div>

      <div className="mt-8 overflow-x-auto">
        <div className="flex gap-4 sm:gap-6">
          {screenshots.map((src) => (
            <div key={src} className="min-w-[240px] max-w-[280px] flex-1">
              <div className="card relative overflow-hidden rounded-2xl border border-slate-100">
                <Image src={src} alt="Capture d’écran de Cléa" width={520} height={1040} className="h-auto w-full object-cover" />
              </div>
            </div>
          ))}
        </div>
      </div>
    </section>
  )
}