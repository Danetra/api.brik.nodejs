const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");
const routerServer = require("./src/Routes/main");

const app = express();
const PORT = 2023;

app.use(cors());
app.use(bodyParser.json());
app.use(routerServer);

app.listen(`${PORT}`, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
