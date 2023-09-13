require("dotenv").config();
const db = require("../../Databases/database");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const moment = require("moment");

const JWT_KEY = process.env.JWT_KEY;

const loginService = async (request) => {
  let email = request.email;
  let password = request.password;
  let { user, count } = await getUser(email);
  let token = "";
  if (count === 1) {
    if (await bcrypt.compare(password, user.password)) {
      token = generateToken(user);

      return token;
    } else {
      return 400;
    }
  } else {
    return 404;
  }
};

const registerService = async (request) => {
  let email = request.email;
  let response;

  let { count } = await getUser(email);
  if (count === 1) {
    response = {
      code: 401,
      status: false,
      message: "Email already used",
    };
  } else if (request.password !== request.confirmPassword) {
    response = {
      code: 400,
      status: false,
      message: "Password is not match",
    };
  } else {
    let password = await bcrypt.hash(request.password, 10);
    let query = `INSERT INTO users ("firstName", "lastName", "phoneNum", "roleId", email, password, created_at, updated_at) VALUES ($1, $2, $3, $4, $5, $6, $7, $8)`;

    let data = [
      request.firstName,
      request.lastName,
      request.phoneNum,
      2,
      request.email,
      password,
      moment().format("YYYY-MM-DD HH:mm:ss"),
      moment().format("YYYY-MM-DD HH:mm:ss"),
    ];

    await db.query(query, data);

    response = {
      code: 200,
      status: true,
      message: "Success inserted",
      data: {
        fullName: `${request.firstName} ${
          request.lastName ? request.lastName : ""
        }`,
      },
    };
  }
  return response;
};

const getUser = async (email) => {
  var result = await db.query(`SELECT * FROM users where email = $1`, [email]);
  return { user: result.rows[0], count: result.rowCount };
};

const generateToken = (user, time = 3600 * 2) => {
  let namaDepan = Buffer.from(user.firstName).toString("base64");
  return jwt.sign(
    {
      id: user.id,
      namaDepan: namaDepan,
    },
    JWT_KEY,
    { expiresIn: time }
  );
};

module.exports = { loginService, registerService };
