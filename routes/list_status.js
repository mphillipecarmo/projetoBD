import express from 'express'
import { nextTick } from 'process';
import db from '../db.js'

const router = express.Router()


/* GET página inicial */
router.get('/',async (req, res, next)=>{
    res.render('list_status',{success: req.flash('succes'),
                              error: req.flash('error'),
                              funcionario:true})


})

router.post('/',async (req, res, next)=>{
    const {sts_CPF} = req.body;
    console.log( sts_CPF)
    try {

        const [lista_usuario] = await db.execute(`SELECT nome ,telefone, emal, status, diasbloqueado from usuario where CPF = '${sts_CPF}';`)
        console.log(lista_usuario.length)
        if(lista_usuario.length === 0){
            console.log(lista_usuario.sqlMessage)
            throw Error('Usuario não encontrado')
        }
        const [lista_usuario_livros] = await db.execute(`SELECT lvr.nome, lvr.autor,lvr.volume,lvr.ano, emp.dataemprestimo, emp.renova from livro lvr left join emprestimo emp on lvr.id = emp.id_livro where emp.usuario = '${sts_CPF}';`)

        res.format ({
            html :()=> res.render('list_status',
            {lista_usuario:lista_usuario,lista_usuario_livros:lista_usuario_livros,funcionario:true})
        })
        //res.redirect('/teste')
    } catch (error) {

        res.format({html: ()=> {
            res.render('list_status', {error:error.message})
             
         }})
        
    }
})


export default router