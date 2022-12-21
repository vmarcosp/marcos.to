import Page from "pages/Article.mjs";
export { getStaticProps, getStaticPaths } from "pages/Article.mjs";

export default function Article(props) {
  return <Page {...props} />;
}

Article.getLayout = Page.getLayout;
