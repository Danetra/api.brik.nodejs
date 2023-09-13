require("dotenv").config();
const jwt = require("jsonwebtoken");

const JWT_KEY = process.env.JWT_KEY;
const USERNAME = process.env.USERNAME;
const PASSWORD = process.env.PASSWORD;

const verifyToken = async (req, res, next) => {
  var token = req.header("Authorization")
    ? req.headers["authorization"].split(" ")[1]
    : false;

  if (token === false) {
    return res.status(401).json({
      status: false,
      message: "Unauthorized"
    });
  }

  jwt.verify(token, JWT_KEY, (err, user) => {
    if (err) {
      return res.status(403).json({
        status: false,
        message: "Token is Invalid"
      });
    }
    req.user = user;
    next();
  });
};

module.exports = { verifyToken };
