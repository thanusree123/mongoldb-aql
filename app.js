// function checkDiscount(isMember) {
//     let discount = 0; 
//     if (isMember) {
//         discount = 20; 
//     }
//     console.log("Your discount is:", discount); 
// }
// console.log("--- Testing Member ---");
// checkDiscount(true);  
// console.log("--- Testing Non-Member ---");
// checkDiscount(false);

// variables 
// const pi=1.2345;
// let currentscore=15;
// currentscore=25;
// {
//     let backgroud="hidden";
//     var global="everywhere";
// }
// console.log(global);

// data types
// const developername="alex"
// const experenice=5
// const isBackendDeveloper=true
// let futureproject
// const emptybaseconnection=null

// const developerprofile={
//     name:"alex",
//     age:28,
//     role:"fullstack engineering "
// }
// console.log(developerprofile)
// console.log(developername)
// console.log(experenice)
// console.log(emptybaseconnection)

// operations
// let total=10+5
// let diff=10-5
// let product=10*5
// let quotient=10/2
// let remainder=10%2
// console.log(total)
// console.log(diff)
// console.log(product)
// console.log(quotient)
// console.log(remainder)

// comparison operations
// console.log(5=="5")
// console.log(5==="5")
// console.log(10>=5)
// console.log(10!=5)


// logical operations
// var password=false
// var confirmpassword=true
// const wrong =password&&confirmpassword
// const right=password||confirmpassword
// console.log(wrong)
// console.log(right)

// control & statements
// const accountbalance=500
// const itemcost=1200
// if(accountbalance>=itemcost){
//     console.log("purchase approved")
// }else if(accountbalance+1000>=itemcost){
//     console.log("purchase approved using overdraft")
// }else{
//     console.log("inefficent funds")
// }

// switch statements
// const user="customer"
// switch(user){
//     case "admin":
//     console.log("full access")
//     break
//     case "editor":
//     console.log("content modification")
//     break
//     default:
//         console.log("no access")
// }

// for loop
// for(let i=0;i<5;i++){
//     console.log(i)
// }


// while loop
// let fuel=3
// while(fuel>0){
//     console.log("fuel level "+fuel)
//     fuel--
// }

// functions
function calculateTax(amount){
    return amount*0.15
}
const taxvalue=calculateTax(100)
console.log(taxvalue)

// arrow funtion
// const multiplysum=(num)=>{
//     return num*2
// }
// const nums=multiplysum(5)
// console.log(nums)


// const multiplysum =num=>num*2
// let nums= multiplysum(10)
// console.log(nums)

// // Initializing an Object
// const serverConfig = {
//     port: 3000,
//     environment: "production",
//     sslEnabled: true
// };

// // // Accessing Object Properties using Dot Notation
// // console.log(`Server is initializing on port ${serverConfig.port} under ${serverConfig.environment}.`);




// arrays
const products=[
    {id:1,name:"laptop",category:"electronic",prices:75000,quantity:2},
    {id:2,name:"phone",category:"electronic",prices:30000,quantity:3},
    {id:3,name:"shoes",category:"fashion",prices:4000,quantity:5},
    {id:4,name:"watch",category:"fashion",prices:12000,quantity:1},
    {id:5,name:"headphones",category:"electronic",prices:5000,quantity:4},
];
//  filter 
const electronics=products.filter(product=>{
    return product.category ==="electronic";
});
console.log(electronics)
console.table(electronics)


// map
// Create new array with total value
// total = price * quantity

const productotals=products.map(product=>{
    return{
        name:product.name,
        totalvalue:product.prices*product.quantity
    };
 });
console.log(productotals)











