const authController = require("../../Controllers/Auth/AuthController");

const authRoutes = [
  {
    method: "post",
    route: "login",
    controller: authController.login
  },
  {
    method: "post",
    route: "register",
    controller: authController.register
  }
];

module.exports = authRoutes;
