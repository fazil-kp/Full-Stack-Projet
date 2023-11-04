const express = require('express')
const app = express();
const dotenv = require('dotenv')
const mongoose = require('mongoose')
const cors = require ('cors')
const UserRouter = require('./Router/userRouter')
const creudRouter = require('./Router/crud')


dotenv.config()
app.use(cors())

mongoose.connect(process.env.Mongo_Link).then((data)=>{
    console.log("database connected successfully");
}).catch((err)=>{
    console.log("error",err);
})
app.use(express.json())
app.use('/api/data',UserRouter) // userRouterPage api
app.use('/api/crud',creudRouter)

app.listen(3000,()=>{
    console.log("Port 3000 is connected");
})

// http://localhost:3000/api/data/postdata  // this is the api it used for 1st page(login&signUP)
// http://localhost:3000/api/crud/userProfile  // creud operation