import express from 'express'
import db from '../db.js'

const router = express.Router()


/* GET página inicial */
router.get('/',async (req, res, next)=>{

    try {
       
        const [lista_UsuariosPorLivros] = await db.execute(`select lvr.nome as livro, lvr.autor, emp.nome, emp.emal, emp.usuario,DATE_FORMAT(emp.dataemprestimo,'%d-%m-%Y') dataemprestimo from emprestimo_nome emp inner join livro lvr on lvr.id = emp.id_livro order by emp.dataemprestimo`)
        //let temp = Object.entries(pendente)
        console.log(lista_UsuariosPorLivros)
        res.format ({
            html :()=> res.render('lista_ultimoDia',{lista_UsuariosPorLivros:lista_UsuariosPorLivros,funcionario:true}),
            json: () => res.json({lista_UsuariosPorLivros})
        })
        
    } catch (error) {
        console.log(error)
    }
       

})


export default router