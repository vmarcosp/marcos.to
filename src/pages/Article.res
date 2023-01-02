open AncestorSite

module GetStaticPaths = Next.Page.GetStaticPaths
module GetStaticProps = Next.Page.GetStaticProps

module Styles = {
  let simpleCode = Emotion.css({
    "padding": `0.1em 0.4em`,
    "fontSize": "0.92em",
    "fontFamily": Theme.Fonts.recoleta,
    "color": Theme.colors(#gray100),
    "border": `solid 1px ${Theme.colors(#gray200)}`,
    "borderRadius": `0.3em`,
  })

  let paragraph = {
    "color": Theme.colors(#gray200),
    "fontWeight": 400,
    "fontSize": "1.8rem",
    "lineHeight": "3.2rem",
    "> code": simpleCode,
  }->Media.md({
    "fontSize": "2.0rem",
    "lineHeight": "3.4rem",
  })

  let h2 = {
    "marginTop": 46,
    "fontSize": "2.4rem",
    "fontWeight": 600,
    "lineHeight": "3.2rem",
  }->Media.md({
    "fontSize": "2.8rem",
    "fontWeight": 700,
  })

  let anchor = {
    "color": Theme.colors(#black),
    "textDecoration": "underline",
  }

  let ul = {
    "padding": 0,
    "marginLeft": 32,
  }

  let li = {
    "marginBottom": 16,
    "color": Theme.colors(#gray200),
    "fontSize": "1.6rem",
    "lineHeight": "2.8rem",
    "> code": simpleCode,
  }->Media.md({
    "fontSize": "1.8rem",
    "lineHeight": "3.0rem",
  })

  let figure = {
    "display": "flex",
    "justifyContent": "center",
    "alignItems": "center",
    "flexDirection": "column",
  }

  let figcaption = {
    "marginTop": 24,
    "fontSize": "1.4rem",
    "fontWeight": 500,
    "fontStyle": "italic",
  }

  let img = {
    "marginTop": 32,
    "borderRadius": 8,
    "height": "auto",
    "maxWidth": "100%",
  }

  let pre = {
    "fontFamily": Theme.Fonts.recoleta,
    "fontSize": "1.6rem",
    "lineHeight": "2.8rem",
    "borderRadius": 8,
  }->Media.md({
    "fontSize": "1.8rem",
  })

  let container = Emotion.css({
    "p": paragraph,
    "h2": h2,
    "a": anchor,
    "> ul": ul,
    "> ul > li": li,
    "> figure": figure,
    "figcaption": figcaption,
    "> img, > figure > img": img,
    "> pre, > pre > code": pre,
  })

  let backButton = Emotion.css(
    {
      "marginBottom": 32,
      "cursor": "pointer",
      "border": 0,
      "fontWeight": 600,
      "letterSpacing": "-0.01em",
      "backgroundColor": "transparent",
      "fontSize": "2.0rem",
      "color": Theme.colors(#black),
      "textDecoration": "none",
      "display": "flex",
      "gap": 4,
      "> span": {
        "display": "block",
        "letterSpacing": "-0.04em",
        "transition": "transform 200ms",
      },
      "&:hover": {
        "> span": {
          "transform": "translateX(-6px)",
        },
      },
    }->Media.lg({
      "position": "fixed",
      "left": "50%",
      "marginLeft": -(792 / 2 + 172),
      "top": 96,
    }),
  )->Emotion.compose(CommonStyles.focusable)
}

module BackButton = {
  @react.component
  let make = () => {
    <Next.Link href="/writing" className=Styles.backButton>
      <span> {"<<"->React.string} </span>
      {" Go back"->React.string}
    </Next.Link>
  }
}

module Header = {
  @react.component
  let make = (~title, ~excerpt, ~publishedAt, ~readingTime) => {
    <Stack
      gap={xs: #one(2.0), md: #one(3.0)} borderBottom={xs: (1->#px, #solid, #gray400)} pb={xs: 4.0}>
      <Stack
        direction={xs: #horizontal}
        alignItems={xs: #center}
        gap={xs: #one(2.0)}
        divider={<Base
          borderRadius={xs: 1.0} bgColor={xs: #gray200} width={xs: 4->#px} height={xs: 4->#px}
        />}>
        <ArticleStats> {publishedAt->DateFns.format("PP")} </ArticleStats>
        <ArticleStats> {`${readingTime->Int.toString} min read`} </ArticleStats>
      </Stack>
      <Stack gap={xs: #one(1.5), md: #one(2.0)}>
        <Typography tag=#h1 m={xs: 0.0} fontSize={xs: 3.6->#rem, md: 4.6->#rem} color={xs: #black}>
          {title->React.string}
        </Typography>
        <Typography
          tag=#p
          letterSpacing={xs: -0.02->#em}
          m={xs: 0.0}
          lineHeight={xs: 3.0->#rem, md: 3.6->#rem}
          color={xs: #gray200}
          fontSize={xs: 2.0->#rem, md: 2.0->#rem}>
          {excerpt->React.string}
        </Typography>
      </Stack>
    </Stack>
  }
}

type params = {slug: string}
type props = {post: BlogClient.post}

let default = ({post}: props) => {
  <Box
    px={xs: 3.0, sm: 4.0} py={xs: 8.0, md: 12.0} display={xs: #flex} justifyContent={xs: #center}>
    <Box width={xs: 100.->#pct} maxW={xs: 792->#px} position={xs: #relative}>
      <BackButton />
      <Header
        title=post.title
        excerpt=post.excerpt
        publishedAt={post.publishedAt->Date.fromString}
        readingTime={post.readingTimeInMinutes}
      />
      <div className=Styles.container dangerouslySetInnerHTML={"__html": post.content} />
    </Box>
  </Box>
}

let transformMDtoHtml = async content => {
  open Remark
  let result = await remark()->use(Html.html, Some({"sanitize": false}))->process(content)
  result->String.make
}

let getStaticPaths: GetStaticPaths.t<params> = {
  open GetStaticPaths
  async () => {
    paths: BlogClient.getSlugs()->Belt.Array.map(slug => {params: {slug: slug}}),
    fallback: false,
  }
}

NextHelpers.withCustomLayout(default, children => <div> children </div>)

let getStaticProps: GetStaticProps.t<props, params, unit> = async context => {
  let post = BlogClient.getPostBySlug(context.params.slug)
  let html = await transformMDtoHtml(post.content)

  let postWithHtml = {
    ...post,
    content: html,
  }
  {"props": {post: postWithHtml}}
}
