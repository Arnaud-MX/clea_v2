import { metrics } from '@/app/data'

export default function Metrics() {
  return (
    <section className="bg-white/60">
      <div className="mx-auto max-w-7xl px-4 py-12 sm:py-14 md:py-16">
        <div className="grid items-center gap-6 text-center sm:grid-cols-3">
          {metrics.map((m) => (
            <div key={m.label} className="reveal">
              <div className="text-3xl font-semibold text-primary sm:text-4xl">{m.value}</div>
              <div className="mt-1 text-slate-600">{m.label}</div>
            </div>
          ))}
        </div>
      </div>
    </section>
  )
}