import express from 'express'
import db from '../db.js'

const router = express.Router()


/* GET página inicial */
router.get('/', (req, res)=>{
    res.format({html: ()=> {
       res.render('index',{funcionario:true})
        
    }})
       

})


export default router