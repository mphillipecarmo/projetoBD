import express from 'express'
import { nextTick } from 'process';
import db from '../db.js'

const router = express.Router()


/* GET página inicial */
router.get('/',async (req, res, next)=>{
    res.render('EmprestarLivro')


})

router.post('/',async (req, res, next)=>{
    const { emp_id_livro, emp_CPF} = req.body;
    console.log(emp_id_livro + ' ' + emp_CPF)
    try {
        const [emprestimo] = await db.execute(`INSERT INTO emprestimo VALUES ('${emp_id_livro}','${emp_CPF}',CURDATE(),3)`)
       
        if(!emprestimo || emprestimo.affectedRows < 1 ){
            console.log(emprestimo.sqlMessage)
            throw new Error('emprestimo não foi inserido corretamente')
        }
        console.log('Livro emprestado com sucesso')
        res.send({ok:true})
        //res.redirect('/teste')
    } catch (error) {

        console.log(error)
    }
})

export default router