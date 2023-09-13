const {
  loginService,
  registerService
} = require("../../Services/Auth/AuthServices");

const login = async (req, res) => {
  let request = req.body;
  let login = await loginService(request);
  if (login === 404) {
    res.status(404).json({
      status: 404,
      message: "User Not Found"
    });
  } else if (login === 400) {
    res.status(400).json({
      status: 400,
      message: "Invalid Password"
    });
  } else {
    res.status(200).json({
      status: 200,
      name: "authorization",
      type: "bearer",
      token: login,
      expire: 3600
    });
  }
};

const register = async (req, res) => {
  let request = req.body;
  let register = await registerService(request);
  res.status(register.code).json(register);
};

module.exports = { login, register };
