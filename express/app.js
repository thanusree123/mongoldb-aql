// const express=require("express");
// const app=express()
// app.use(express.json())
// app.get("/",(req,res)=>{
//     res.send("hello express")
// });
//     app.get("/about",(req,res)=>{
//         res.send("About page")
//     });
//     app.get("/users",(req,res)=>{
//         res.send("Users page");
//     });
//     app.get("/users/:id", (req, res) => {
//         console.log(req.params.id);
//     });
    
// app.listen(3000,()=>{
//     console.log("server running 3000 port")
// });

// app.get("/users", (req, res) => {
//     res.send("Get users");
// });

// app.post("/users", (req, res) => {
//     res.send("Create user");
// });

// app.put("/users/1", (req, res) => {
//     res.send("Replace user 1");
// });

// app.patch("/users/1", (req, res) => {
//     res.send("Update part of user 1");
// });

// app.delete("/users/1", (req, res) => {
//     res.send("Delete user 1");
// });

const express = require("express");

const app = express();

app.use(express.json());

app.get("/users", (req, res) => {
    res.json([
        { id: 1, name: "Thanu" },
        { id: 2, name: "Ravi" }
    ]);
});

app.listen(3000, () => {
    console.log("Server running on port 3000");
});
// app.use((req, res, next) => {
//     console.log("Middleware executed");
//     next();
// });

// app.get("/", (req, res) => {
//     res.send("Home");
// });
app.use((req,res,next)=>{
    console.log("middleware");
    next();
});
app.get("/",(req,res)=>{
    res.send("Visit")
});