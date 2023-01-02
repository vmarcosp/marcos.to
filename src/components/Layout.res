open AncestorSite

@react.component
let make = (~children) => {
  <Box
    height={xs: 100.0->#pct} px={xs: 3.0, sm: 4.0} display={xs: #flex} justifyContent={xs: #center}>
    <Stack height={xs: 100.0->#pct} width={xs: 100.->#pct} maxW={xs: 792->#px}>
      <Header />
      <Box flexGrow={xs: #num(3.0)} tag=#main> children </Box>
      <Footer />
    </Stack>
  </Box>
}
