open AncestorSite

module GetStaticProps = Next.Page.GetStaticProps
module Hero = Home_Hero

type props = {posts: array<BlogClient.post>}

let default = ({posts}) => {
  <Stack gap={xs: #one(8.0)} pb={xs: 8.0}>
    <Hero />
    <Stack
      gap={xs: #one(4.0), md: #one(4.0)} pt={sm: 16.0, md: 18.0} alignItems={xs: #"flex-start"}>
      <Box mt={xs: 3.0}>
        <Badge> "Latest posts" </Badge>
      </Box>
      <Grid spacing={xs: 3.0, md: 4.0}>
        {posts
        ->Belt.Array.mapWithIndex((key, post) => {
          <Box columns={xs: #12, md: #6} key={key->Belt.Int.toString}>
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
  </Stack>
}

let getStaticProps: GetStaticProps.t<props, unit, unit> = async _ =>
  {
    "props": {posts: BlogClient.getLatestPosts()},
  }
