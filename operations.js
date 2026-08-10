// test> use college
// switched to db college
// college> db.students.find({
// | major:"Computer science",
// | cgpa:{$gt:8.0},
// | semester:{$ne:1}
// | })

// college> db.dtudents.updateOne(
// | {rollno:"cs101",
// | {$addToSet:{subjects:"Database system"}}
// Uncaught:
// SyntaxError: Unexpected token (3:0)

//   1 | db.dtudents.updateOne(
//   2 | {rollno:"cs101",
// > 3 | {$addToSet:{subjects:"Database system"}}
//     | ^
//   4 |

// college> db.dtudents.updateOne( {rollno:"cs101"}, {$addToSet:{subjects:"Database system"}})
// {
//   acknowledged: true,
//   insertedId: null,
//   matchedCount: 0,
//   modifiedCount: 0,
//   upsertedCount: 0
// }
// college> db.students.find({
// | cgpa:{$gte:7.0,$lte:9.0},
// | major:{$in:["Computer Science","Electrical"]},
// | })
// [
//   {
//     _id: ObjectId('6a773fd67ba2794553844bc2'),
//     rollno: 'CS101',
//     name: 'aisha sharma',
//     major: 'Computer Science',
//     semster: 3,
//     cgpa: 8.8,
//     subjects: [ 'Data structure', 'Database system' ]
//   }
// ]
// college> db.students.find({
// | age:{$lte:21}})
// [
//   {
//     _id: ObjectId('6a7579eb4ee862f113791ddc'),
//     name: 'Thanu',
//     age: 21,
//     branch: 'Aiml'
//   },
//   {
//     _id: ObjectId('6a757e754ee862f113791dde'),
//     name: 'Anita',
//     age: 20,
//     branch: 'Ece',
//     cgpa: 9.2
//   },
//   {
//     _id: ObjectId('6a757e754ee862f113791de0'),
//     name: 'Sneha',
//     age: 21,
//     branch: 'aiml',
//     cgpa: 9.6,
//     skills: [ 'Java', 'Python' ]
//   }
// ]
// college> db.students.find({
// | major:{$nin:"Mechanical"},
// | cgpa:{$gt:8.0}})
// MongoServerError[BadValue]: $nin needs an array
// college> db.students.find({ major:{$ne:"Mechanical"},
// | cgpa:{$gt:8.0}})
// [
//   {
//     _id: ObjectId('6a757cbc4ee862f113791ddd'),
//     name: 'Rahul',
//     age: 22,
//     branch: 'Cse',
//     cgpa: 8.7,
//     skills: [ 'Java', 'Python' ]
//   },
//   {
//     _id: ObjectId('6a757e754ee862f113791dde'),
//     name: 'Anita',
//     age: 20,
//     branch: 'Ece',
//     cgpa: 9.2
//   },
//   {
//     _id: ObjectId('6a757e754ee862f113791ddf'),
//     name: 'Vikram',
//     age: 22,
//     branch: 'Mechanical',
//     cgpa: 8.4
//   },
//   {
//     _id: ObjectId('6a757e754ee862f113791de0'),
//     name: 'Sneha',
//     age: 21,
//     branch: 'aiml',
//     cgpa: 9.6,
//     skills: [ 'Java', 'Python' ]
//   },
//   {
//     _id: ObjectId('6a773fd67ba2794553844bc2'),
//     rollno: 'CS101',
//     name: 'aisha sharma',
//     major: 'Computer Science',
//     semster: 3,
//     cgpa: 8.8,
//     subjects: [ 'Data structure', 'Database system' ]
//   }
// ]
// college> db.students.find({
// | $or:[
// | {semester:1},
// | {cgpa:{$gt:9.0}}
// | ]
// | })
// [
//   {
//     _id: ObjectId('6a757e754ee862f113791dde'),
//     name: 'Anita',
//     age: 20,
//     branch: 'Ece',
//     cgpa: 9.2
//   },
//   {
//     _id: ObjectId('6a757e754ee862f113791de0'),
//     name: 'Sneha',
//     age: 21,
//     branch: 'aiml',
//     cgpa: 9.6,
//     skills: [ 'Java', 'Python' ]
//   }
// ]
// college> db.students.find({
// | $nor:[
// | {major:"Electrical"},
// | {major:{"Mechanical"}
// Uncaught:
// SyntaxError: Unexpected token (4:20)

//   2 | $nor:[
//   3 | {major:"Electrical"},
// > 4 | {major:{"Mechanical"}
//     |                     ^
//   5 |

// college> db.employees.aggregate([
// | {
// |     $group:{
// |         _id:"$dept",
// |         totalEmployees:{ $sum:1 },
// |         averageSalary:{ $avg:"$salary" },
// |         highestSalary:{ $max:"$salary" },
// |         lowestSalary:{ $min:"$salary" }
// |     }
// | }
// | ])

// college> db.student.find({
// |   $nor: [
// |     { major: "Mechanical" },
// |     { major: "Electrical" }
// |   ]
// | })

// college> db.find.students.find({
// | $or:[
// | {semester:3},
// | {major:"Computer Science"}
// | ]})

// college> db.students.find({
// | $nor:[
// | {cgpa:{$lt:7.0}},
// | {semester:1}
// | ]
// | })
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
//   },
//   {
//     _id: ObjectId('6a757e754ee862f113791dde'),
//     name: 'Anita',
//     age: 20,
//     branch: 'Ece',
//     cgpa: 9.2
//   },
//   {
//     _id: ObjectId('6a757e754ee862f113791ddf'),
//     name: 'Vikram',
//     age: 22,
//     branch: 'Mechanical',
//     cgpa: 8.4
//   },
//   {
//     _id: ObjectId('6a757e754ee862f113791de0'),
//     name: 'Sneha',
//     age: 21,
//     branch: 'aiml',
//     cgpa: 9.6,
//     skills: [ 'Java', 'Python' ]
//   },
//   {
//     _id: ObjectId('6a773fd67ba2794553844bc2'),
//     rollno: 'CS101',
//     name: 'aisha sharma',
//     major: 'Computer Science',
//     semster: 3,
//     cgpa: 8.8,
//     subjects: [ 'Data structure', 'Database system' ]
//   }
// ]
// college> db.students.find({
// | name:{$regex:"^a",$options:i}
// | })
// ReferenceError: i is not defined
// college> db.students.find({ name: { $regex: "^a", $options: "i" } })
// [
//   {
//     _id: ObjectId('6a757e754ee862f113791dde'),
//     name: 'Anita',
//     age: 20,
//     branch: 'Ece',
//     cgpa: 9.2
//   },
//   {
//     _id: ObjectId('6a773fd67ba2794553844bc2'),
//     rollno: 'CS101',
//     name: 'aisha sharma',
//     major: 'Computer Science',
//     semster: 3,
//     cgpa: 8.8,
//     subjects: [ 'Data structure', 'Database system' ]
//   }
// ]
// college> db.students.find({
// | name:{regex:"Singh$"}
// | })

// college> db.students.find({
// | major{regex:"Science",$options:"i"}
// Uncaught:
// SyntaxError: Unexpected token, expected "," (2:5)

//   1 | db.students.find({
// > 2 | major{regex:"Science",$options:"i"}
//     |      ^
//   3 |

// college> })
// Uncaught:
// SyntaxError: Unexpected token (1:0)

// > 1 | })
//     | ^
//   2 |

// college> db.students.find({
// | major:{regex:"Science",$options:"i"}})

// college> db.students.find({
// | major:{$regex:"Science",$options:"i"}})
// [
//   {
//     _id: ObjectId('6a773fd67ba2794553844bc2'),
//     rollno: 'CS101',
//     name: 'aisha sharma',
//     major: 'Computer Science',
//     semster: 3,
//     cgpa: 8.8,
//     subjects: [ 'Data structure', 'Database system' ]
//   }
// ]
// college> db.students.find({
// | name:{$regex:"kumar",options:"i"}})
// MongoServerError[BadValue]: unknown operator: options
// college> db.students.find({
// | name:{$regex:"kumar",$options:"i"}})

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
//   },
//   {
//     _id: ObjectId('6a757e754ee862f113791dde'),
//     name: 'Anita',
//     age: 20,
//     branch: 'Ece',
//     cgpa: 9.2
//   },
//   {
//     _id: ObjectId('6a757e754ee862f113791ddf'),
//     name: 'Vikram',
//     age: 22,
//     branch: 'Mechanical',
//     cgpa: 8.4
//   },
//   {
//     _id: ObjectId('6a757e754ee862f113791de0'),
//     name: 'Sneha',
//     age: 21,
//     branch: 'aiml',
//     cgpa: 9.6,
//     skills: [ 'Java', 'Python' ]
//   },
//   {
//     _id: ObjectId('6a773fd67ba2794553844bc2'),
//     rollno: 'CS101',
//     name: 'aisha sharma',
//     major: 'Computer Science',
//     semster: 3,
//     cgpa: 8.8,
//     subjects: [ 'Data structure', 'Database system' ]
//   }
// ]
// college> db.students.find({
// | rollno:{$regex:"^CS",$options:"i"}})
// [
//   {
//     _id: ObjectId('6a773fd67ba2794553844bc2'),
//     rollno: 'CS101',
//     name: 'aisha sharma',
//     major: 'Computer Science',
//     semster: 3,
//     cgpa: 8.8,
//     subjects: [ 'Data structure', 'Database system' ]
//   }
// ]
// college> db.students.updateOne(
// | {rollno:"CS101"},
// | {$push:{subject:"Artifical Intelligence"}
// | )
// Uncaught:
// SyntaxError: Unexpected token, expected "," (4:0)

//   2 | {rollno:"CS101"},
//   3 | {$push:{subject:"Artifical Intelligence"}
// > 4 | )
//     | ^
//   5 |

// college> db.students.updateOne( {rollno:"CS101"}, {$push:{subject:"Artifical Intelligence"}} )
// {
//   acknowledged: true,
//   insertedId: null,
//   matchedCount: 1,
//   modifiedCount: 1,
//   upsertedCount: 0
// }
// college> db.students.updateOne(
// | {rollno:{"CS101"},
// Uncaught:
// SyntaxError: Unexpected token (2:16)

//   1 | db.students.updateOne(
// > 2 | {rollno:{"CS101"},
//     |                 ^
//   3 |

// college> db.students.updateOne(
// | {rollno:"CS101"},
// | {$addToSet:{subject:"Web Dev"}}
// | )
// {
//   acknowledged: true,
//   insertedId: null,
//   matchedCount: 1,
//   modifiedCount: 1,
//   upsertedCount: 0
// }
// college> db.students.updateMany(
// | {},{$pull:{subjects:"Chemistry"}})
// {
//   acknowledged: true,
//   insertedId: null,
//   matchedCount: 6,
//   modifiedCount: 0,
//   upsertedCount: 0
// }
// college> db.students.updateOne(
// | {rollno:"CS101"},
// | {$pop:{subjects:1}})
// {
//   acknowledged: true,
//   insertedId: null,
//   matchedCount: 1,
//   modifiedCount: 1,
//   upsertedCount: 0
// }
// college> db.students.updateOne(
// | {rollno:"CS101"},
// | {$pop:{subjects:-1}})
// {
//   acknowledged: true,
//   insertedId: null,
//   matchedCount: 1,
//   modifiedCount: 1,
//   upsertedCount: 0
// }
// college> db.students.updateOne(
// | {rollno:"ME302"},
// | {$push:{subjects:"Physcics"}})
// {
//   acknowledged: true,
//   insertedId: null,
//   matchedCount: 0,
//   modifiedCount: 0,
//   upsertedCount: 0
// }
// college> db.students>updateOne(
// | {rollno:"CS101"},
// | {$addToSet:{subjects:"Cloud Computing"}})
// ReferenceError: updateOne is not defined
// college> db.students. updateOne( { rollno: "CS101" }, { $addToSet: { subjects: "Cloud Computing" } })
// {
//   acknowledged: true,
//   insertedId: null,
//   matchedCount: 1,
//   modifiedCount: 1,
//   upsertedCount: 0
// }
// college> 
