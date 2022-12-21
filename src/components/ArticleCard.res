open AncestorSite

type lang = [#english | #portuguese]

module Styles = {
  let card = Emotion.css(
    {
      "transition": "background-color 200ms",
      "backgroundColor": "#eee",
      "cursor": "default",
    }->Media.md({
      "backgroundColor": "transparent",
      "&:hover": {
        "backgroundColor": "#eee",
      },
    }),
  )

  let cardLink = Emotion.css({
    "textDecoration": "none",
  })
}

@react.component
let make = (~title, ~text, ~lang: lang, ~readingTime, ~slug, ~publishedAt) => {
  <Next.Link className={Styles.cardLink} href={`/writing/${slug}`}>
    <Stack
      className=Styles.card
      borderRadius={xs: 0.75}
      py={xs: 3.0}
      px={xs: 3.0}
      gap={xs: #one(1.0)}
      tag=#article>
      <Typography fontSize={xs: 2.2->#rem} fontWeight={xs: #700} color={xs: #black}>
        {title->React.string}
      </Typography>
      <Typography fontSize={xs: 1.8->#rem} lineHeight={xs: 2.8->#rem} color={xs: #gray100}>
        {text->React.string}
      </Typography>
      <Stack
        mt={xs: 2.5}
        gap={xs: #one(1.5)}
        alignItems={xs: #center}
        direction={xs: #horizontal}
        divider={<Base
          borderRadius={xs: 1.0} bgColor={xs: #gray200} width={xs: 4->#px} height={xs: 4->#px}
        />}>
        <ArticleStats> {`${readingTime->Belt.Int.toString} min read`} </ArticleStats>
        <ArticleStats> {publishedAt->DateFns.format("PP")} </ArticleStats>
        <ArticleStats>
          {switch lang {
          | #english => "🇺🇸"
          | #portuguese => "🇧🇷"
          }}
        </ArticleStats>
      </Stack>
    </Stack>
  </Next.Link>
}
