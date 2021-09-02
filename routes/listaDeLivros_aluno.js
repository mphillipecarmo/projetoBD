import express from 'express'
import db from '../db.js'

const router = express.Router()


/* GET página inicial */
router.get('/',async (req, res, next)=>{
    try {
        
        const [livro] = await db.execute(`SELECT * from livro`)
        //let temp = Object.entries(pendente)
        console.log(livro)
        res.format ({
            html :()=> res.render('listaDeLivros_aluno',{livro:livro,aluno:true}),
            json: () => res.json({livro})
        })
        
    } catch (error) {
        console.log(error)
    }

})


export default router