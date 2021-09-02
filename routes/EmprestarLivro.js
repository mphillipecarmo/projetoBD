import express from 'express'
import { nextTick } from 'process';
import db from '../db.js'

const router = express.Router()


/* GET página inicial */
router.get('/',async (req, res, next)=>{
    try {
        
        const [livro] = await db.execute(`SELECT * from livro`)
        //let temp = Object.entries(pendente)
        console.log(livro)
        res.format ({
            html :()=> res.render('EmprestarLivro',{livro:livro,funcionario:true}),
            json: () => res.json({livro})
        })
        
    } catch (error) {
        console.log(error)
    }


})

router.post('/',async (req, res, next)=>{
    const { emp_id_livro, emp_CPF} = req.body;
    const [livro] = await db.execute(`SELECT * from livro`)
    console.log(emp_id_livro + ' ' + emp_CPF)
    try {
        const [emprestimo] = await db.execute(`INSERT INTO emprestimo VALUES ('${emp_id_livro}','${emp_CPF}',CURDATE(),3)`)
        console.log(emprestimo)
        if(!emprestimo || emprestimo.affectedRows < 1 ){
            console.log(emprestimo.sqlMessage)
            throw new Error('emprestimo não foi inserido corretamente')
        }
        console.log('Livro emprestado com sucesso')
        res.format({html: ()=> {
            res.render('EmprestarLivro', {success:'Livro emprestado com sucesso',livro:livro,funcionario:true})
             
         }})

        //res.redirect('/teste')
    } catch (error) {

        console.log(error)
        res.format({html: ()=> {
            res.render('EmprestarLivro', {error:error.message,livro:livro,aluno:true})
             
         }})
    }
})

export default router