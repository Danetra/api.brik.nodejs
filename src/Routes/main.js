const router = require("express").Router();
const authRoutes = require("./Auth/routeAuth");
const productRoutes = require("./Products/routeProducts");
const baseAPI = "/api/v1";

router.get("/api/v1", async (req, res) => {
  res.status(200).json("BRIK API V.1");
});

// Auth Function
authRoutes.forEach((auth) => {
  router[auth.method](`${baseAPI}/${auth.route}`, auth.controller);
});

productRoutes.forEach((product) => {
  router[product.method](
    `${baseAPI}/${product.route}`,
    product.middleware,
    product.controller
  );
});

module.exports = router;
