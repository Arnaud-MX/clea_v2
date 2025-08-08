type StoreButtonsProps = {
  variant?: 'default' | 'inverted'
}

export default function StoreButtons({ variant = 'default' }: StoreButtonsProps) {
  const base = variant === 'inverted' ? 'btn-primary-inverted' : 'btn-primary'
  const text = variant === 'inverted' ? 'text-primary' : 'text-white'

  return (
    <div className="flex flex-wrap items-center gap-3">
      <a
        href="#" /* TODO: Remplacer par le vrai lien App Store */
        aria-label="Télécharger sur l’App Store"
        className={`${base} h-12 gap-3 pr-4 pl-3`}
      >
        <AppStoreIcon className={text} />
        <span className="sr-only md:not-sr-only md:inline">App Store</span>
      </a>
      <a
        href="#" /* TODO: Remplacer par le vrai lien Google Play */
        aria-label="Télécharger sur Google Play"
        className={`${base} h-12 gap-3 pr-4 pl-3`}
      >
        <GooglePlayIcon className={text} />
        <span className="sr-only md:not-sr-only md:inline">Google Play</span>
      </a>
    </div>
  )
}

function AppStoreIcon({ className = '' }: { className?: string }) {
  return (
    <svg width="28" height="28" viewBox="0 0 24 24" fill="none" role="img" aria-hidden="true" className={className}>
      <path d="M12 2c1.5 0 2.4.6 3.3 1.5.9.9 1.2 2.1 1.2 3.4 0 1.4-.7 2.7-1.5 3.5-.8.8-1.9 1.6-3 1.6-1.1 0-2.3-.8-3.1-1.6-.8-.8-1.4-2.1-1.4-3.5 0-1.3.5-2.5 1.4-3.4C9.9 2.6 10.7 2 12 2Z" fill="currentColor"/>
      <path d="M4.5 20c.5 1 1.7 2 3 2 1.3 0 1.7-.6 3-.6s1.7.6 3 .6c1.3 0 2.4-1 2.9-2 .3-.6.6-1.5.6-2.6 0-1.9-.8-3.7-2.1-4.9-1-.9-2.2-1.5-3.5-1.5s-2.6.6-3.6 1.5C6.4 13.7 5.5 15.5 5.5 17.4c0 1.1.2 2 .5 2.6Z" fill="currentColor"/>
    </svg>
  )
}

function GooglePlayIcon({ className = '' }: { className?: string }) {
  return (
    <svg width="28" height="28" viewBox="0 0 24 24" fill="none" role="img" aria-hidden="true" className={className}>
      <path d="M3 4.5c0-.9.9-1.5 1.7-1.1l11.6 6.1-3.1 3.1L3 4.5Z" fill="currentColor"/>
      <path d="M3 19.5c0 .9.9 1.5 1.7 1.1l8.5-4.5-2.9-2.9L3 19.5Z" fill="currentColor"/>
      <path d="M19.8 10.3 16 8.3 12.9 11.4l3.3 3.3 3.7-2a1.9 1.9 0 0 0 0-3.4Z" fill="currentColor"/>
    </svg>
  )
}