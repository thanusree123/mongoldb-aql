db.pets.insertMany([
    { name: "Luna", type: "cat", age: 2, hobbies: ["napping", "climbing"] },
    { name: "Max", type: "dog", age: 5, hobbies: ["running", "fetching"] },
    { name: "Goldie", type: "fish", age: 1, hobbies: ["swimming"] }
  ])
  db.pets.find()
  db.pets.find({type:"cat"})
  db.pets.find({age:{$gt:3}})
  db.pets.find().sort({ age: 1 })
  db.pets.find({}, { name: 1 }).limit(2)
  db.pets.updateOne(
    { name: "Luna" }, 
    { $set: { age: 3 } }
  )
  db.pets.updateOne( { name: "Luna" }, { $set: { age: 3 } } )
  db.pets.deleteOne({ name: "Goldie" })
  db.pets.deleteMany({ type: "fish" })
  db.pets.drop()