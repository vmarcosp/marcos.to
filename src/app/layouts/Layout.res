_import("@/styles/global.css")

let classes = css("./layout.module.css")

let metadata: Next.Metadata.t = {
  title: "Marcos Oliveira",
  description: "UI engineer focused on crafting outstanding products and tools.",
  openGraph: {
    title: "Marcos Oliveira",
    description: "UI Engineer focused on crafting outstanding products and tools.",
    url: "https://marcos.id",
    siteName: "Marcos Oliveira",
    images: [
      {
        url: "https://marcos.id/og.jpg",
        width: 1200,
        height: 630,
      }
    ]
  }
}

@react.component
let make = (~children) => {
  <html lang="en">
    <Next.GoogleTagManager gtmId="GTM-P3FDXCZD" />
    <body className={clsx(["light", classes["container"]])}>
      <Fonts.Script />
      <Next.SpeedInsights />
      <Header />
      <main> {children} </main>
      <Footer />
    </body>
  </html>
}
