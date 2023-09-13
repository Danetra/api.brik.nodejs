const {
  ListServices,
  DetailServices,
  PostServices,
} = require("../../Services/Products/ProductsServices");

const listProducts = async (req, res) => {
  const response = await ListServices(req);
  res.status(response.status).json(response);
};

const detailProduct = async (req, res) => {
  let product;
  const response = await DetailServices(req);

  product = {
    id: response.id,
    products: {
      name: response.name,
      sku: response.sku,
      description: response.description,
      price: response.price,
      specification: {
        weight: response.weight,
        width: response.width,
        length: response.length,
        height: response.height,
      },
      seller: {
        fullName: `${response.firstName} ${
          response.lastName ? response.lastName : ""
        }`,
        timePosted: response.created_at,
        timeEdited: response.updated_at,
      },
    },
  };
  return res.status(200).json({
    status: 200,
    data: product,
  });
};

const postProduct = async (req, res) => {
  let body = req.body;
  let response = await PostServices(body);
  res.status(response.code).json(response);
};

module.exports = { listProducts, detailProduct, postProduct };
