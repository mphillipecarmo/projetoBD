import express from 'express'
import { nextTick } from 'process';
import db from '../db.js'

const router = express.Router()


/* GET página inicial */
router.get('/',async (req, res, next)=>{
    res.render('Devolver_livro',{funcionario:true})


})

router.post('/',async (req, res, next)=>{
    const { dvr_id_livro, dvr_CPF} = req.body;
    console.log(dvr_id_livro + ' ' + dvr_CPF)
    try {
        const [devolver] = await db.execute(`DELETE from emprestimo where id_livro = ${dvr_id_livro} and usuario = '${dvr_CPF}'`)
       
        if(!devolver || devolver.affectedRows < 1 ){
            console.log(devolver.sqlMessage)
            throw new Error('Falha ao devolver livro')
        }
        console.log('Livro devolvido com sucesso')
        res.format({html: ()=> {
            res.render('Devolver_livro', {success:'Livro devolvido com sucesso'})
             
         }})
        //res.redirect('/teste')
    } catch (error) {

        console.log(error)
        res.format({html: ()=> {
            res.render('Devolver_livro', {error:error.message})
             
         }})
    }
})


export default router