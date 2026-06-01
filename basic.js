const { MongoClient } = require('mongodb');

// Connection URL for a local MongoDB instance
const url = 'mongodb://localhost:27017';
const client = new MongoClient(url);
const dbName = 'myPetsDatabase';

async function main() {
  // 1. Connect to the server
  await client.connect();
  console.log('Successfully connected to MongoDB!');
  
  const db = client.db(dbName);
  const collection = db.collection('pets');

  // 2. Clear out any old data so we start fresh
  await collection.deleteMany({});

  // 3. Insert your pets
  await collection.insertMany([
    { name: "Luna", type: "cat", age: 2, hobbies: ["napping", "climbing"] },
    { name: "Max", type: "dog", age: 5, hobbies: ["running", "fetching"] },
    { name: "Goldie", type: "fish", age: 1, hobbies: ["swimming"] }
  ]);
  console.log("-> Pets inserted successfully.");

  // 4. Find all cats
  const cats = await collection.find({ type: "cat" }).toArray();
  console.log("-> Cats found:", cats);

  // 5. Find pets older than 3
  const olderPets = await collection.find({ age: { $gt: 3 } }).toArray();
  console.log("-> Pets older than 3:", olderPets);

  return 'All tasks done!';
}

main()
  .then(console.log)
  .catch(console.error)
  .finally(() => client.close());
  