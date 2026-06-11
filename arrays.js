const products=[
    {id:1,name:"Laptop",category:"Electronics",price:50000,quantity:2},
    {id:2,name:"Phone",category:"Electronics",price:30000,quantity:3},
    {id:3,name:"shoes",category:"Fashion",price:4000,quantity:5},
    {id:4,name:"Watch",category:"Fashion",price:12000,quantity:1},
    {id:5,name:"Headphones",category:"Electronics",price:5000,quantity:4},
];
// console.table(products)

// filter
// const electronics=products.filter(product=>{
//     return product.category=="Electronics"
// });
// console.log(electronics)


// map
// const totalproducts=products.map(product=>{
//     return{
//     name:product.name,
//     totalvalue:product.price*product.quantity
//     };
// });
// console.log(totalproducts)



// reduce
// const totalinventoryworth=products.reduce((accumulator,product)=>{
// return accumulator+(product.price*product.quantity)
// },0);
// console.log(totalinventoryworth)


// combined operation Filter,Map,reduce,
// const electronicworth=products.filter(product=>product.category==="Fashion")
// .map(product=>product.price * product.quantity)
// .reduce((sum,value)=>sum+value,0)
// console.log(electronicworth)

// to get product in uppercase
// const uppercase=products.map(product=>{
//     return product.name.toUpperCase();
// })
// console.log(uppercase)


// filer expensionproducts
// const expensive=products.filter(product=>{
//     return product.price>10000;
// })
// console.log(expensive)


// count totalquantity
// const totalquantity=products.reduce((sum,product)=>{
//     return sum+product.quantity;
// },0);
// console.log(totalquantity)


// advance array operation in node js 

// const number=[10,20,30,40,50,60,70,80];
// console.log(number)

// // push
// number.push(90);
// console.log(number)

// pop last element is removed
// number.pop()
// console.log(number)

// add a number at beginning
// 

// shift removes first element
// number.shift()
// console.log(number)

// slice extract  portion from array
// const slicenum=number.slice(2,5);
// console.log(slicenum)

// splice remove/insert elements
// number.splice(2,3,999,888)
// console.log(number)


// sort
// const unsorted = [45, 12, 89, 2, 77, 1];
// console.log(unsorted)

// // unsorted.sort()
// unsorted.sort((a,b)=>(a-b))
// JavaScript
// (a,b) => a-b
// Negative → a before b
// Positive → b before a
// console.log(unsorted)


// reverse
// unsorted.reverse();
// console.log(unsorted)

// concat
// const arr=[1,2,3]
// const arr1=[4,5,6]
// const combine=arr.concat(arr1)
// console.log(combine)


// includes it tells does it has it or not 
// console.log(combine.includes(5))
// console.log(combine.includes(100))

// indexof return the indexes
// console.log(combine.indexOf(4));
// console.log(combine.indexOf(99))


// foreach
// combine.forEach((value,index)=>{
//     console.log(index,value)
// });

// map
// const squared=combine.map(num=>num*num)
// console.log(squared)

// filter
// const evennum=combine.filter(num=>num%2===0)
// console.log(evennum)

// reduce
// const sum=combine.reduce((accumulator,current)=>{
//     return accumulator+current
// })
// console.log(sum)


// finds first element
// const found=combine.find(num=>num>4)
// console.log(found)

// some true or false
// const hasnegve=combine.some(num=>num>0)
// console.log(hasnegve)


// every  true or false
// const allpositive=combine.every(num=>num>0)
// console.log(allpositive)


// const nestedArray = [1, 2, [3, 4], [5, [6, 7]]];
// console.log(nestedArray)

// const flatArray = nestedArray.flat(2);
// console.log(flatArray);


// destructuring
// const[first,second,...remaining]=combine;
// console.log("First :", first);
// console.log("Second:", second);
// console.log("Remaining:", remaining);


// spread operation
// const copied=[combine]
// console.log(copied)


// chaining operation
// const numbers = [10, 20, 30, 40, 50, 60, 70, 80];
// const finalresult=numbers
// .filter(num=>num>20)
// .map(num=>num*2)
// .reduce((sum,num)=>sum+num,0)
// console.log(finalresult)


const students = [
    {name: "A", marks: 90},
    {name: "B", marks: 40},
    {name: "C", marks: 80}
  ];

const pass=students.filter(student=>{
    return student.marks>50
})
// console.log(pass)

const names=students.filter(student=>{
    return student.name
})
// console.log(names)

const total=students.filter(student=>student.marks>50)
.map(student=>student.name)
console.log(total)












