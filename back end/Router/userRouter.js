const router = require('express').Router()

const user = require('../Models/userModel')
const crypto = require('crypto-js')
const jwt = require('jsonwebtoken')


// SignUp Method

router.post('/postdata',async(req,res)=>{
    console.log('req.body',req.body);

    try{
        const newdata = new user({
            name:req.body.username,
            email:req.body.email,
            password:crypto.AES.encrypt(req.body.password,process.env.crypto_seceret).toString()       
        })
        const saveddata= await newdata.save()
        res.status(200).json(saveddata)

    }catch(err){
        console.log(err);
        res.status(500).json(err)
    }
})

// Login Method

router.post('/logindata',async(req,res)=>{
    console.log('backend login',req.body);

    try{
        const dataBaseData= await user.findOne({email:req.body.email})
        console.log('**********',dataBaseData);
        !dataBaseData && res.status(401).json("Check your email")
        console.log('backend data',dataBaseData);

        const decPassword = crypto.AES.decrypt(dataBaseData.password,process.env.crypto_seceret)
        const ogPassword = decPassword.toString(crypto.enc.Utf8)

        console.log('Original password',ogPassword);

        ogPassword != req.body.password && res.status(401).json("Email and Password are doesnot match")

        // res.status(200).json("Login Successfully")


        const token= jwt.sign({
            id:dataBaseData._id
        },process.env.jwt_seceret,
        {expiresIn:"7d"})

        const {password,...others}=dataBaseData._doc  //spred operator using merging and copying
        
console.log('accesstoken',token);
        res.status(200).json({...others,token})
    }catch(e){
        res.status(500).json(err)

    }

})





module.exports=router