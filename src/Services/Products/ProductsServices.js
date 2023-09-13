require("dotenv").config();
const db = require("../../Databases/database");
const moment = require("moment");

const ListServices = async (req) => {
  try {
    let data;

    let page = req.query.page;
    let limit = req.query.limit;
    let offset = (page - 1) * limit;

    let query = listQuery(limit, offset);
    let response = await db.query(query);

    let products = response.rows.map((item) => {
      return {
        id: item.id,
        products: {
          name: item.name,
          sku: item.sku,
          description: item.description,
          price: item.price,
          specification: {
            weight: item.weight,
            width: item.width,
            length: item.length,
            height: item.height,
          },
          seller: {
            fullName: `${item.firstName} ${item.lastName ? item.lastName : ""}`,
            timePosted: item.created_at,
            timeEdited: item.updated_at,
          },
        },
      };
    });

    let totalDocs = response.rowCount;
    let totalPages = Math.ceil(totalDocs / limit);

    if (totalDocs > 0) {
      data = {
        status: 200,
        data: {
          docs: products,
          // docs: response.rows,
          page: page,
          limit: limit,
          totalDocs: totalDocs,
          totalPages: totalPages,
        },
      };
    } else {
      data = {
        status: 404,
        message: "Product's Empty",
        data: {
          docs: response.rows,
          page: page,
          limit: limit,
          totalDocs: totalDocs,
          totalPages: totalPages,
        },
      };
    }
    return data;
  } catch (error) {
    console.log(error);
  }
};

const DetailServices = async (req) => {
  try {
    let userId = req.params.id;

    let { query, values } = detailQuery(userId);

    let response = await db.query(query, values);
    return response.rows[0];
  } catch (error) {
    console.log(error);
  }
};

const PostServices = async (body) => {
  try {
    let response;
    let { count } = await checkProduct(body.name);

    if (count > 0) {
      response = {
        code: 401,
        status: false,
        message: "Product Already Exist",
      };
    } else {
      let sku = generateRandom(6);

      let { query, data } = postQuery(body);

      await db.query(query, data);

      response = {
        code: 200,
        status: true,
        message: "Success inserted",
        data: {
          productName: body.name,
        },
      };
    }
    return response;
  } catch (error) {
    console.log(error);
  }
};

// Penggunaan Query dan Tools Variable
const listQuery = (limit, offset) => {
  return `SELECT a.created_at, a.updated_at, a.id, a.name, a.sku, a.description, a.price, a.weight, a.width, a.length, a.height, a."image", b."firstName", b."lastName" FROM products as a INNER JOIN users as b ON a."userId" = b.id INNER JOIN category as c ON a."CategoryId" = c.id ORDER BY a.created_at DESC LIMIT ${limit} OFFSET ${offset}`;
};

const detailQuery = (userId) => {
  let query = `SELECT a.created_at, a.updated_at, a.id, a.name, a.sku, a.description, a.price, a.weight, a.width, a.length, a.height, a."image", b."firstName", b."lastName" FROM products as a INNER JOIN users as b ON a."userId" = b.id INNER JOIN category as c ON a."CategoryId" = c.id WHERE a.id = $1`;
  let values = [userId];
  return { query, values };
};

const checkProduct = async (name) => {
  let query = "SELECT name FROM products WHERE name = $1";
  let values = [name];
  let result = await db.query(query, values);
  return {
    products: result.rows[0] ? result.rows[0] : [],
    count: result.rowCount,
  };
};

const postQuery = () => {
  let query = `INSERT INTO products ("userId", name, sku, "CategoryId", description, price, weight, width, length, height, image, created_at, updated_at) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13)`;

  let data = [
    body.userId,
    body.name,
    sku,
    body.CategoryId,
    body.description,
    body.price,
    body.weight,
    body.width,
    body.length,
    body.height,
    body.image,
    moment().format("YYYY-MM-DD HH:mm:ss"),
    moment().format("YYYY-MM-DD HH:mm:ss"),
  ];

  return { query, data };
};

const generateRandom = (length) => {
  let string = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  let random = "";

  for (let i = 0; i < length; i++) {
    let index = Math.floor(Math.random() * string.length);
    random += string.charAt(index);
  }

  return random;
};

module.exports = { ListServices, DetailServices, PostServices };
