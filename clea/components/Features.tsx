import { features } from '@/app/data'

export default function Features() {
  return (
    <section className="mx-auto max-w-7xl px-4 py-14 sm:py-16 md:py-20">
      <div className="mx-auto max-w-2xl text-center">
        <h2 className="reveal text-2xl font-semibold text-text sm:text-3xl">Tout pour comprendre et agir</h2>
        <p className="reveal mt-3 text-slate-600">Trois outils clés pour situer ton patrimoine, le projeter et agir avec des conseils adaptés.</p>
      </div>
      <div className="mt-10 grid gap-5 sm:grid-cols-2 md:mt-12 md:grid-cols-3">
        {features.map((f) => (
          <div key={f.id} className="card p-6">
            <div className="mb-4 inline-flex h-12 w-12 items-center justify-center rounded-xl bg-primaryLight text-primary">
              <Icon name={f.icon} />
            </div>
            <h3 className="text-lg font-semibold text-text">{f.title}</h3>
            <p className="mt-2 text-slate-600">{f.description}</p>
          </div>
        ))}
      </div>
    </section>
  )
}

function Icon({ name }: { name: 'bar-chart' | 'trending-up' | 'sparkles' }) {
  switch (name) {
    case 'bar-chart':
      return (
        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" aria-hidden="true">
          <path d="M5 20V10" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />
          <path d="M12 20V6" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />
          <path d="M19 20v-8" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />
        </svg>
      )
    case 'trending-up':
      return (
        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" aria-hidden="true">
          <path d="M3 17 10 10l4 4 7-7" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" />
          <path d="M14 7h7v7" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" />
        </svg>
      )
    case 'sparkles':
      return (
        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" aria-hidden="true">
          <path d="M12 3l1.5 3.5L17 8l-3.5 1.5L12 13l-1.5-3.5L7 8l3.5-1.5L12 3Z" fill="currentColor" />
          <path d="M19 14l.9 2.1L22 17l-2.1.9L19 20l-.9-2.1L16 17l2.1-.9L19 14Z" fill="currentColor" />
        </svg>
      )
  }
}