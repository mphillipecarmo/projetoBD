import express from 'express'
import { nextTick } from 'process';
import db from '../db.js'

const router = express.Router()


/* GET página inicial */
router.get('/',async (req, res, next)=>{
    try {
        console.log('pendencia')
        
        const [pendente] = await db.execute(`SELECT * from usuario where status = 'block'`)
        //let temp = Object.entries(pendente)
        console.log(pendente)
        res.format ({
            html :()=> res.render('list_pendencia',{pendente:pendente}),
            json: () => res.json({pendente})
        })
        
    } catch (error) {
        console.log(error)
    }

})


export default router