import express from 'express'
import db from '../db.js'

const router = express.Router()


/* GET página inicial */
router.get('/',async (req, res, next)=>{
    res.render('consultar_datas',{success: req.flash('succes'),
                              error: req.flash('error'),
                              aluno:true})


})


router.post('/',async (req, res, next)=>{
    const {csd_CPF} = req.body;
    console.log( csd_CPF)
    try {

        const [csd_lista_usuario] = await db.execute(`SELECT nome ,telefone, emal, status, diasbloqueado from usuario where CPF = '${csd_CPF}';`)
        console.log(csd_lista_usuario.length)
        if(csd_lista_usuario.length === 0){
            console.log(csd_lista_usuario.sqlMessage)
            throw Error('Usuario não encontrado')
        }
        const [csd_lista_usuario_livros] = await db.execute(`SELECT lvr.nome, lvr.autor,lvr.volume,lvr.ano, emp.dataemprestimo, emp.renova from livro lvr left join emprestimo emp on lvr.id = emp.id_livro where emp.usuario = '${csd_CPF}';`)

        res.format ({
            html :()=> res.render('consultar_datas',
            {csd_lista_usuario:csd_lista_usuario,csd_lista_usuario_livros:csd_lista_usuario_livros,aluno:true})
        })
        //res.redirect('/teste')
    } catch (error) {

        res.format({html: ()=> {
            res.render('consultar_datas', {error:error.message})
             
         }})
        
    }
})



export default router