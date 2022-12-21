open AncestorSite

@react.component
let make = (~children) => {
  <Typography tag=#span fontWeight={xs: #500} fontSize={xs: 1.6->#rem} color={xs: #black}>
    {React.string(children)}
  </Typography>
}
