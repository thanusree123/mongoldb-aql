// test> use college
// switched to db college
// college> db.students.insertOne({
// | rollno:"CS101",
// | name:"aisha sharma",
// | major:"Computer Science",
// | semster:3,
// | cgpa:8.5,
// | subjects:["Data structure","Database system"]
// | })
// {
//   acknowledged: true,
//   insertedId: ObjectId('6a773fd67ba2794553844bc2')
// }
// college> db.student.insertMany([
// | {rollno:"EE205",name:"Ravi kumar",major:"Electorical",semester:5,cgpa:8.5,subjects:["Signal","Microprocessors"]},
// | {rollno:"ME302",name:"Priya patel",major:"Mechnical",semester:3,cgpa:9.1,subjects:["Thermodynamics","Mechanics"]},
// | {rollno:"CS102",name:"Arjun Singh",major:"Computer Science",semester:3,cgpa:8.2,subjects:["Data structure","web dev"]}
// | ])
// {
//   acknowledged: true,
//   insertedIds: {
//     '0': ObjectId('6a77418b7ba2794553844bc3'),
//     '1': ObjectId('6a77418b7ba2794553844bc4'),
//     '2': ObjectId('6a77418b7ba2794553844bc5')
//   }
// }
// college> db.find()
// TypeError: db.find is not a function
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
//     cgpa: 8.5,
//     subjects: [ 'Data structure', 'Database system' ]
//   }
// ]
// college> db.students.find({major:"Computer science"})

// college> db.students.find({major:"Computer Science"})
// [
//   {
//     _id: ObjectId('6a773fd67ba2794553844bc2'),
//     rollno: 'CS101',
//     name: 'aisha sharma',
//     major: 'Computer Science',
//     semster: 3,
//     cgpa: 8.5,
//     subjects: [ 'Data structure', 'Database system' ]
//   }
// ]
// college> db.students.find({cgpa:{$gt:8.0}})
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
//     cgpa: 8.5,
//     subjects: [ 'Data structure', 'Database system' ]
//   }
// ]
// college> db.students.find(
// | {semester:3},
// | {name:1,major:1,_id:0})

// college> db.students.updateOne(
// | {rollno:"CS101",
// | {$set:{cgpa:8.8}
// Uncaught:
// SyntaxError: Unexpected token (3:0)

//   1 | db.students.updateOne(
//   2 | {rollno:"CS101",
// > 3 | {$set:{cgpa:8.8}
//     | ^
//   4 |

// college> db.students.updateOne( {rollno:"CS101"}, {$set:{cgpa:8.8})
// Uncaught:
// SyntaxError: Unexpected token, expected "," (1:57)

// > 1 | db.students.updateOne( {rollno:"CS101"}, {$set:{cgpa:8.8})
//     |                                                          ^
//   2 |

// college> db.students.updateOne( {rollno:"CS101"}, {$set:{cgpa:8.8}})
// {
//   acknowledged: true,
//   insertedId: null,
//   matchedCount: 1,
//   modifiedCount: 1,
//   upsertedCount: 0
// }
// college> db.students.updateMany(
// | {semester:3},
// | {$inc:{semester:1}}
// | )
// {
//   acknowledged: true,
//   insertedId: null,
//   matchedCount: 0,
//   modifiedCount: 0,
//   upsertedCount: 0
// }
// college> db.students.updateOne(
// | {rollno:"EE205"},
// | 
