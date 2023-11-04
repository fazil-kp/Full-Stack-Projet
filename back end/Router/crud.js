const router = require('express').Router()

const user = require('../Models/userModel');
const { verifyToken, verifyTokenAuthorization } = require('../verify_token');

router.get('/userProfile/:id',verifyToken,verifyTokenAuthorization, async(req,res)=>{
    console.log(`profileSuccess ${req.params.id}`);
    const pdata=req.params.id
    try{
        const profileData= await user.findById(pdata)  // getting all the datas in databse
        res.status(200).json(profileData)
    }catch(e){
        res.status(500).json(e)

    }
})

module.exports=router
