var express = require("express");
var app = express();

var path = require("path");

var PORT = 8080;

app.use(express.static(path.join(__dirname, "client")));

app.listen(PORT, () => {
  console.log("app listening on port 8080");
});