export const getLayout = (fn) => fn.getLayout;
export const withCustomLayout = (component, fn) => (component.getLayout = fn);
