async function start() {
  const [{ r: reactModule, t: reactDomModule }, pageModule] = await Promise.all([
    import("/_next/static/chunks/framework-BgSIrAUN.js"),
    import(
      location.pathname.startsWith("/device-bridge")
        ? "/_next/static/chunks/page-D6n7nsrF.js"
        : "/_next/static/chunks/page-HfwU_Y3c.js"
    ),
  ]);

  const React = reactModule();
  const ReactDOM = reactDomModule();
  ReactDOM.createRoot(document.getElementById("root")).render(
    React.createElement(pageModule.default),
  );
}

start().catch((error) => {
  console.error("SafeDrive page startup failed", error);
  document.getElementById("root").innerHTML =
    '<main style="max-width:36rem;margin:12vh auto;padding:2rem;font:16px sans-serif;color:#fff">Trang chưa tải được. Vui lòng tải lại trang.</main>';
});
