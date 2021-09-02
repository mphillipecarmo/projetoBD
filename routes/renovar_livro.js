import express from 'express'
import db from '../db.js'

const router = express.Router()


/* GET página inicial */
router.get('/',async (req, res, next)=>{
    res.render('renovar_livro',{success: req.flash('succes'),
                              error: req.flash('error'),
                              aluno:true})


})


router.post('/',async (req, res, next)=>{
    const {rvr_CPF,rvr_ID} = req.body;
    console.log( rvr_ID)
    try {

        const [rvr_lista_usuario] = await db.execute(`SELECT nome ,telefone, emal, status, diasbloqueado from usuario where CPF = '${rvr_CPF}';`)
        console.log(rvr_lista_usuario.length)
        if(rvr_lista_usuario.length === 0){
            console.log(rvr_lista_usuario.sqlMessage)
            throw Error('Usuario não encontrado')
        }
        const [rvr_lista_usuario_livros] = await db.execute(`SELECT lvr.nome, lvr.autor,lvr.volume,lvr.ano, emp.dataemprestimo, emp.renova from livro lvr left join emprestimo emp on lvr.id = emp.id_livro where emp.usuario = '${rvr_CPF}';`)
        if(rvr_ID !== ''){
            const [rvr_lista_usuario_livros] = await db.execute(`SELECT lvr.nome, lvr.autor,lvr.volume,lvr.ano, emp.dataemprestimo, emp.renova from livro lvr left join emprestimo emp on lvr.id = emp.id_livro where emp.usuario = '${rvr_CPF}';`)
        }


        res.format ({
            html :()=> res.render('renovar_livro',
            {rvr_lista_usuario:rvr_lista_usuario,rvr_lista_usuario_livros:rvr_lista_usuario_livros,aluno:true,rvr_CPF:rvr_CPF})
        })
        //res.redirect('/teste')
    } catch (error) {

        res.format({html: ()=> {
            res.render('renovar_livro', {error:error.message})
             
         }})
        
    }
})






export default router