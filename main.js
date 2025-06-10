const express = require("express");
const { createProxyMiddleware } = require("http-proxy-middleware");
const app = express();

app.use(express.json());

// Generic proxy endpoint
app.use((req, res, next) => {
  // Only handle requests that start with /proxy
  if (!req.path.startsWith("/proxy")) {
    return next();
  }

  const targetUrl = req.headers["x-target-url"];
  if (!targetUrl) {
    return res.status(400).json({ error: "Missing X-Target-URL header" });
  }

  /** @type {import('http-proxy-middleware/dist/types').RequestHandler<express.Request, express.Response>} */
  const proxy = createProxyMiddleware({
    target: targetUrl,
    changeOrigin: true,
    pathRewrite: {
      "^/proxy": "", // Remove /proxy from path
    },
    onProxyReq: (proxyReq, req, res) => {
      // Forward all headers except proxy-specific ones
      Object.keys(req.headers).forEach((key) => {
        if (!key.startsWith("x-target-")) {
          proxyReq.setHeader(key, req.headers[key]);
        }
      });
    },
  });

  proxy(req, res, next);
});

app.listen(3010, () => {
  console.log("Proxy server running on port 3010");
});
