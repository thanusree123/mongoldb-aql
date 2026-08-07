// test> use college
// switched to db college
// college> show dbs
// admin            40.00 KiB
// companyDB       184.00 KiB
// config           72.00 KiB
// local            80.00 KiB
// myPetsDatabase   40.00 KiB
// ordersdb         12.00 KiB
// petsDB           72.00 KiB
// practicedb       72.00 KiB
// schoolDB        108.00 KiB
// college> db.students.insertOne({
// | name:"Thanu",
// | age:21,
// | branch:"Aiml"})
// {
//   acknowledged: true,
//   insertedId: ObjectId('6a7579eb4ee862f113791ddc')
// }
// college> show dbs
// admin            40.00 KiB
// college           8.00 KiB
// companyDB       184.00 KiB
// config           96.00 KiB
// local            80.00 KiB
// myPetsDatabase   40.00 KiB
// ordersdb         12.00 KiB
// petsDB           72.00 KiB
// practicedb       72.00 KiB
// schoolDB        108.00 KiB
// college> db.students.find()
// [
//   {
//     _id: ObjectId('6a7579eb4ee862f113791ddc'),
//     name: 'Thanu',
//     age: 21,
//     branch: 'Aiml'
//   }
// ]
// college> db.students.insertOne({
// | name:"Rahul",
// | age:22,
// | branch:"Cse",
// | cgpa:8.7,
// | skills:["Java","Python"]
// | })
// {
//   acknowledged: true,
//   insertedId: ObjectId('6a757cbc4ee862f113791ddd')
// }
// college> db.students,find()
// ReferenceError: find is not defined
// college> db.students.find()
// [
//   {
//     _id: ObjectId('6a7579eb4ee862f113791ddc'),
//     name: 'Thanu',
//     age: 21,
//     branch: 'Aiml'
//   },
//   {
//     _id: ObjectId('6a757cbc4ee862f113791ddd'),
//     name: 'Rahul',
//     age: 22,
//     branch: 'Cse',
//     cgpa: 8.7,
//     skills: [ 'Java', 'Python' ]
//   }
// ]
// college> db.students.insertMany([
// | {
// | name:"Anita",
// | age:20,
// | branch:"Ece",
// | cgpa:9.2
// | },
// | {
// | name:"Vikram",
// | age:22,
// | branch:"Mechanical",
// | cgpa:8.4
// | },
// | {
// | name:"Sneha",
// | age:21,
// | branch:"aiml",
// | cgpa:9.6,
// | skills:["Java","Python"]
// | }
// | ])
// {
//   acknowledged: true,
//   insertedIds: {
//     '0': ObjectId('6a757e754ee862f113791dde'),
//     '1': ObjectId('6a757e754ee862f113791ddf'),
//     '2': ObjectId('6a757e754ee862f113791de0')
//   }
// }
// college> 
