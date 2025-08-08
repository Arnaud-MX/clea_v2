import StoreButtons from './StoreButtons'

export default function Cta() {
  return (
    <section className="bg-primary text-white">
      <div className="mx-auto max-w-7xl px-4 py-14 sm:py-16 md:py-20">
        <div className="grid items-center gap-8 md:grid-cols-2">
          <div className="reveal space-y-4">
            <h2 className="text-3xl font-semibold sm:text-4xl" style={{ fontSize: 'clamp(28px, 5vw, 40px)' }}>
              Télécharge Cléa et prends le contrôle de ton patrimoine
            </h2>
          </div>
          <div className="reveal md:justify-self-end">
            <StoreButtons variant="inverted" />
          </div>
        </div>
      </div>
    </section>
  )
}