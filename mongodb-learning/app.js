
const { MongoClient } = require("mongodb");
const client = new MongoClient("mongodb://localhost:27017");
console.log(client);
// db.students.find()
// [ { _id: ObjectId('6a303ebcb6ba2a5691cee156'), name: 'A', marks: 90 } ]
// schoolDB> db.students.insertOne({
// | name:"B",
// | marks:40
// | })
// {
//   acknowledged: true,
//   insertedId: ObjectId('6a304038b6ba2a5691cee157')
// }
// schoolDB> db.student.insertOne({
// | name:"C",
// | marks:80
// | })
// {
//   acknowledged: true,
//   insertedId: ObjectId('6a304063b6ba2a5691cee158')
// }
// schoolDB> db.students.find()
// [
//   { _id: ObjectId('6a303ebcb6ba2a5691cee156'), name: 'A', marks: 90 },
//   { _id: ObjectId('6a304038b6ba2a5691cee157'), name: 'B', marks: 40 }
// ]
// schoolDB> db.students.insertOne({
// | name:"C",
// | marks:80
// | })
// {
//   acknowledged: true,
//   insertedId: ObjectId('6a304090b6ba2a5691cee159')
// }
// schoolDB> db.students.find()
// [
//   { _id: ObjectId('6a303ebcb6ba2a5691cee156'), name: 'A', marks: 90 },
//   { _id: ObjectId('6a304038b6ba2a5691cee157'), name: 'B', marks: 40 },
//   { _id: ObjectId('6a304090b6ba2a5691cee159'), name: 'C', marks: 80 }
// ]
// schoolDB> db.students.find({
// | marks:{$gt:50}
// | })
// [
//   { _id: ObjectId('6a303ebcb6ba2a5691cee156'), name: 'A', marks: 90 },
//   { _id: ObjectId('6a304090b6ba2a5691cee159'), name: 'C', marks: 80 }
// ]
// schoolDB> db.students.find({
// | marks:{$lt:50}
// | })
// [ { _id: ObjectId('6a304038b6ba2a5691cee157'), name: 'B', marks: 40 } ]
// schoolDB> db.students.findOne({
// | name:"A"
// | })
// { _id: ObjectId('6a303ebcb6ba2a5691cee156'), name: 'A', marks: 90 }
// schoolDB> db.students.updateOne({
// | name:"A"},
// | $set:{
// Uncaught:
// SyntaxError: Unexpected token, expected "," (3:4)

//   1 | db.students.updateOne({
//   2 | name:"A"},
// > 3 | $set:{
//     |     ^
//   4 |

// schoolDB> db.students.updateOne({
// | name:"A"},
// | {
// | $set:{
// | marks:95
// | }
// | }
// | }
// Uncaught:
// SyntaxError: Unexpected token, expected "," (8:0)

//   6 | }
//   7 | }
// > 8 | }
//     | ^
//   9 |

// schoolDB> db.students.updateOne({
// | | name:"A"},
// | | {
// | | $set:{
// | | marks:95
// | | }
// | | }
// Uncaught:
// SyntaxError: Unexpected token (2:0)

//   1 | db.students.updateOne({
// > 2 | | name:"A"},
//     | ^
//   3 | | {
//   4 | | $set:{
//   5 | | marks:95

// schoolDB> db.students.updateOne({
// | | name:"A"},
// | | {
// | | $set:{
// | | marks:95
// | | }
// | | }
// | | )
// Uncaught:
// SyntaxError: Unexpected token (2:0)

//   1 | db.students.updateOne({
// > 2 | | name:"A"},
//     | ^
//   3 | | {
//   4 | | $set:{
//   5 | | marks:95

// schoolDB> db.students.find()
// [
//   { _id: ObjectId('6a303ebcb6ba2a5691cee156'), name: 'A', marks: 90 },
//   { _id: ObjectId('6a304038b6ba2a5691cee157'), name: 'B', marks: 40 },
//   { _id: ObjectId('6a304090b6ba2a5691cee159'), name: 'C', marks: 80 }
// ]
// schoolDB> db.students.updateOne(
// | {
// | name:"A"
// | },
// | {$set: {
// | marks:95
// | }
// | }
// | )
// {
//   acknowledged: true,
//   insertedId: null,
//   matchedCount: 1,
//   modifiedCount: 1,
//   upsertedCount: 0
// }
// schoolDB> db.students.find()
// [
//   { _id: ObjectId('6a303ebcb6ba2a5691cee156'), name: 'A', marks: 95 },
//   { _id: ObjectId('6a304038b6ba2a5691cee157'), name: 'B', marks: 40 },
//   { _id: ObjectId('6a304090b6ba2a5691cee159'), name: 'C', marks: 80 }
// ]
// schoolDB> db.students.deleteOne({
// | name:"B"})
// { acknowledged: true, deletedCount: 1 }
// schoolDB> db.students.find()
// [
//   { _id: ObjectId('6a303ebcb6ba2a5691cee156'), name: 'A', marks: 95 },
//   { _id: ObjectId('6a304090b6ba2a5691cee159'), name: 'C', marks: 80 }
// ]
// schoolDB> db.students.insertOne({
// | name:"B",
// | marks:40
// | })
// {
//   acknowledged: true,
//   insertedId: ObjectId('6a304c7db6ba2a5691cee15a')
// }
// schoolDB> db.students.find().sort({
// | marks:-1
// | })
// [
//   { _id: ObjectId('6a303ebcb6ba2a5691cee156'), name: 'A', marks: 95 },
//   { _id: ObjectId('6a304090b6ba2a5691cee159'), name: 'C', marks: 80 },
//   { _id: ObjectId('6a304c7db6ba2a5691cee15a'), name: 'B', marks: 40 }
// ]
// schoolDB> db.students.find.sort({
// | marks:1
// | })
// TypeError: db.students.find.sort is not a function
// schoolDB> db.students.find().sort({
// | marks:1
// | })
// [
//   { _id: ObjectId('6a304c7db6ba2a5691cee15a'), name: 'B', marks: 40 },
//   { _id: ObjectId('6a304090b6ba2a5691cee159'), name: 'C', marks: 80 },
//   { _id: ObjectId('6a303ebcb6ba2a5691cee156'), name: 'A', marks: 95 }
// ]
// schoolDB> db.find().sort({
// | marks:-1
// | }).limit(1)
// TypeError: db.find is not a function
// schoolDB> db.students.find().sort({
// | marks:-1
// | }).limit(1)
// [ { _id: ObjectId('6a303ebcb6ba2a5691cee156'), name: 'A', marks: 95 } ]
// schoolDB> db.students.countDocuments()
// 3
// schoolDB> db.students.find({},{ name:1,__id:0})
// [ { name: 'A' }, { name: 'C' }, { name: 'B' } ]
// schoolDB> 