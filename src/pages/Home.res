open AncestorSite

module GetStaticProps = Next.Page.GetStaticProps

let customFadeIn = Animations.fadeIn(~delay=400)

module Name = {
  @react.component
  let make = () => {
    <Typography
      tag=#h1
      className={customFadeIn()}
      m={xs: 0.0}
      fontSize={xs: 3.6->#rem, md: 5.2->#rem}
      color={xs: #black}
      fontFamily={xs: [Theme.Fonts.recoleta]->#custom}>
      {`Hi, I'm Marcos Oliveira.`->React.string}
    </Typography>
  }
}

module Text = {
  @react.component
  let make = (~children) => {
    <Typography
      className={customFadeIn()}
      tag=#p
      letterSpacing={xs: -0.02->#em}
      m={xs: 0.0}
      lineHeight={xs: 3.6->#rem}
      color={xs: #gray200}
      fontSize={xs: 2.2->#rem, md: 2.4->#rem}>
      children
    </Typography>
  }
}
module TextHighlight = {
  @react.component
  let make = (~children) => {
    <Typography color={xs: #black} fontWeight={xs: #500} tag=#span>
      {React.string(children)}
    </Typography>
  }
}

module SocialLinks = {
  @react.component
  let make = () => {
    <Box className={customFadeIn()} display={xs: #flex} justifyContent={xs: #"space-between"}>
      <SocialLink href="mailto:marcosoliveira@duck.com"> "marcosoliveira@duck.com" </SocialLink>
      <Box display={xs: #none, md: #flex} gap={xs: #one(2.0)}>
        <SocialLink href="https://twitter.com/vmaarcosp"> "twitter" </SocialLink>
        <SocialLink href="https://github.com/vmarcosp"> "github" </SocialLink>
      </Box>
    </Box>
  }
}

module Texts = {
  @react.component
  let make = () => {
    <Stack gap={xs: #one(3.0)}>
      <Text>
        {`UI Developer based in `->React.string}
        <TextHighlight> {`Brazil`} </TextHighlight>
        {` crafting products using `->React.string}
        <TextHighlight> "design, functional programming" </TextHighlight>
        {" and "->React.string}
        <Link href="https://rescript-lang.org" target="_blank" color=#black> {"rescript"} </Link>
      </Text>
      <Text>
        {"I'm interested in "->React.string}
        <TextHighlight> "functional programming, ui, dx, design systems" </TextHighlight>
        {" and "->React.string}
        <TextHighlight> "open source." </TextHighlight>
      </Text>
    </Stack>
  }
}

type props = {posts: array<BlogClient.post>}

let default = ({posts}) => {
  <Stack gap={xs: #one(8.0)} pb={xs: 8.0}>
    <Stack mt={xs: 12.0, md: 21.5} gap={xs: #one(1.5)}>
      <Name />
      <Stack gap={xs: #one(6.0), md: #one(11.0)}>
        <Texts />
        <SocialLinks />
      </Stack>
    </Stack>
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
