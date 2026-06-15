
const { MongoClient } = require("mongodb");
const client = new MongoClient("mongodb://localhost:27017");
console.log(client);