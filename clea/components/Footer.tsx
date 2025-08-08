export default function Footer() {
  return (
    <footer className="border-t border-slate-200 bg-white/60">
      <div className="mx-auto max-w-7xl px-4 py-8">
        <div className="flex flex-col items-center justify-between gap-3 text-sm text-slate-600 sm:flex-row">
          <nav aria-label="Liens légaux" className="flex gap-4">
            <a href="#" className="hover:text-primary underline-offset-4 hover:underline">Mentions légales</a>
            <a href="#" className="hover:text-primary underline-offset-4 hover:underline">Politique de confidentialité</a>
          </nav>
          <div>© 2025 Cléa — Tous droits réservés.</div>
        </div>
      </div>
    </footer>
  )
}