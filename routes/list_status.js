import express from 'express'
import { nextTick } from 'process';
import db from '../db.js'

const router = express.Router()


/* GET página inicial */
router.get('/',async (req, res, next)=>{
    res.render('list_status',{success: req.flash('succes'),
                              error: req.flash('error')})


})



export default router