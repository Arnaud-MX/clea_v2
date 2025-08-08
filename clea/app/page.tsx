import Hero from '@/components/Hero'
import Features from '@/components/Features'
import Metrics from '@/components/Metrics'
import Testimonials from '@/components/Testimonials'
import Screenshots from '@/components/Screenshots'
import Cta from '@/components/Cta'
import Footer from '@/components/Footer'

export default function Home() {
  return (
    <main>
      <Hero />
      <Features />
      <Metrics />
      <Testimonials />
      <Screenshots />
      <Cta />
      <Footer />
    </main>
  )
}
