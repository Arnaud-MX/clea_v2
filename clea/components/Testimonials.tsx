import Image from 'next/image'
import { testimonials } from '@/app/data'

export default function Testimonials() {
  return (
    <section className="bg-blueSoft">
      <div className="mx-auto max-w-7xl px-4 py-14 sm:py-16 md:py-20">
        <div className="mx-auto max-w-2xl text-center">
          <h2 className="reveal text-2xl font-semibold text-text sm:text-3xl">Ils nous font confiance</h2>
          <p className="reveal mt-3 text-slate-700">Des milliers d’utilisateurs évaluent leur patrimoine et progressent avec Cléa.</p>
        </div>
        <div className="mt-10 grid gap-5 sm:grid-cols-2 md:mt-12 md:grid-cols-3">
          {testimonials.map((t) => (
            <figure key={t.name} className="card flex flex-col gap-4 p-6">
              <div className="flex items-center gap-3">
                <Image src={t.avatar} alt={`Avatar de ${t.name}`} width={40} height={40} className="h-10 w-10 rounded-full object-cover" />
                <figcaption className="font-medium text-text">{t.name}</figcaption>
              </div>
              <blockquote className="text-slate-700">“{t.text}”</blockquote>
            </figure>
          ))}
        </div>
      </div>
    </section>
  )
}