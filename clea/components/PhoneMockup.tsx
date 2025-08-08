import Image from 'next/image'

type PhoneMockupProps = {
  image: string
  alt?: string
}

export default function PhoneMockup({ image, alt = '' }: PhoneMockupProps) {
  return (
    <div className="mx-auto w-[300px] sm:w-[340px] md:w-[380px]">
      <div className="relative rounded-[2.5rem] bg-slate-900 p-2" style={{ boxShadow: '0 10px 30px rgba(30,136,229,0.12)' }}>
        <div className="rounded-[2rem] bg-black p-2">
          <div className="relative overflow-hidden rounded-[1.6rem] bg-slate-800">
            <Image
              src={image}
              alt={alt}
              width={720}
              height={1480}
              className="h-auto w-full object-cover"
              priority
            />
          </div>
        </div>
        {/* Notch */}
        <div className="absolute left-1/2 top-2 h-6 w-24 -translate-x-1/2 rounded-b-2xl bg-black" aria-hidden="true" />
      </div>
    </div>
  )
}