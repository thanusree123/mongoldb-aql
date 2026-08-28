// test> use college
// switched to db college
// college> db.createCollection("students",{
// | validator:{
// | $jsonSchema:{
// | bsonType:"object",
// | required:["name","major","cgpa"],
// | properties:{
// | name:{
// | bsonType:"string",
// | description:"name must be a string and it is required"
// | },
// | cgpa:{
// | bsonType:"double",
// | minimum:0.0,
// | maximum:10.0,
// | description:"cgpa must be a number between 0.0 and 10.0"
// | },
// | major:{
// | enum:["Computer Science","Electrical","Mechanical"],
// | description:"major can only be one of the specified allowed string"
// | }
// | }
// | }
// | }
// | }) 
// MongoServerError[NamespaceExists]: namespace college.students already exists, but with different options: 
// { uuid: UUID("06c45990-bbfe-4fa7-8cb3-02319b676409") }
// college> db.createCollection("student",
//      { validator: 
//         { $jsonSchema:
//              { bsonType: "object", required: ["name", "major", "cgpa"],
//                 properties: 
//                 { name: { bsonType: "string", description: "name must be a string and it is required" }, 
//                 cgpa: { bsonType: "double", minimum: 0.0, maximum: 10.0, description: "cgpa must be a number between 0.0 and 10.0" },
//                  major: { enum: ["Computer Science", "Electrical", "Mechanicollege> 
//                     db.createCollection("student
// | ", { validator:
//  { $jsonSchema: 
//     { bsonType: "object", required: ["name", "major", "cgpa"], properties: 
//         { name: { bsonType: "string", description: "name must be a string and it is required" }, 
//         cgpa: { bsonType: "double", minimum: 0.0, maximum: 10.0, description: "cgpa must be a number between 0.0 and 10.0" },
//          major: { enum: ["Computer Science", "Electrical", "Mechanical"],
//              description: "major can only be one of the specified allowed string" } } }