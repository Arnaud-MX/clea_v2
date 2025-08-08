export const hero = {
  title: 'Découvre ton rang patrimonial en 2 minutes',
  subtitle:
    "Compare ta situation financière avec celle des Français de ton âge et reçois des conseils personnalisés par notre IA.",
  phoneImage: '/screen-1.png',
}

export const features = [
  {
    id: 'ranking',
    title: 'Classement patrimonial',
    description: 'Vois où tu te situes par rapport aux Français de ton âge.',
    icon: 'bar-chart',
  },
  {
    id: 'projection',
    title: "Simulation d’épargne",
    description: 'Projette ton patrimoine sur 1 à 30 ans.',
    icon: 'trending-up',
  },
  {
    id: 'ai',
    title: 'Conseils IA personnalisés',
    description: 'Recommandations adaptées à ton profil.',
    icon: 'sparkles',
  },
] as const

export const metrics = [
  { value: '+10 000', label: 'Utilisateurs actifs' },
  { value: '4,8/5', label: 'Note moyenne' },
  { value: '2 min', label: "Temps d’analyse" },
] as const

export const testimonials = [
  {
    name: 'Caroline',
    avatar: '/caroline.png',
    text: 'Superbe app finance, rapide et pédagogique.',
  },
  {
    name: 'Julien',
    avatar: '/julien.png',
    text: 'Une application claire, j’ai compris mon niveau en un clin d’œil.',
  },
  {
    name: 'Thomas',
    avatar: '/thomas.png',
    text: 'Des conseils pertinents pour passer un cap.',
  },
] as const

export const screenshots = [
  '/screen-1.png',
  '/screen-2.png',
  '/screen-3.png',
  '/screen-4.png',
  '/screen-5.png',
] as const