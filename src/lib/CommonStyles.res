let focusable = Emotion.css({
  "outline": 0,
  "borderRadius": 2,
  "transition": "box-shadow 250ms",
  "&:focus-visible": {
    "boxShadow": `0px 0px 0px 2px ${Theme.colors(#gray100)}`,
  },
})
