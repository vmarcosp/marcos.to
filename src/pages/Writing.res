open AncestorSite

module GetStaticProps = Next.Page.GetStaticProps

type props = {posts: array<BlogClient.post>}

let default = ({posts}: props) => {
  <Stack mt={xs: 12.0, md: 16.0} gap={xs: #one(4.0), md: #one(8.0)}>
    <Typography
      className={Animations.fadeIn(~delay=250, ())}
      tag=#h1
      textAlign={xs: #center}
      m={xs: 0.0}
      fontSize={xs: 3.2->#rem, md: 4.6->#rem}
      color={xs: #black}
      fontFamily={xs: [Theme.Fonts.recoleta]->#custom}>
      {`Learn, Share & Repeat.`->React.string}
    </Typography>
    <Grid spacing={xs: 3.0, md: 4.0}>
      {posts
      ->Belt.Array.mapWithIndex((key, post) => {
        let animationDelay = key * 100 + 350
        <Box
          className={Animations.fadeFromBottom(~delay=animationDelay, ~duration=400, ())}
          columns={xs: #12, md: #6}
          key={key->Belt.Int.toString}>
          <ArticleCard
            slug=post.slug
            title=post.title
            text=post.excerpt
            publishedAt={post.publishedAt->Date.fromString}
            readingTime={post.readingTimeInMinutes}
            lang=post.lang
          />
        </Box>
      })
      ->React.array}
    </Grid>
  </Stack>
}

let getStaticProps: GetStaticProps.t<props, unit, unit> = async _ =>
  {
    "props": {posts: BlogClient.getPosts()},
  }
