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
    console.log('Este é o id' + rvr_ID)
    try {

        const [rvr_lista_usuario] = await db.execute(`SELECT nome ,telefone, emal, status, diasbloqueado from usuario where CPF = '${rvr_CPF}';`)
        console.log(rvr_lista_usuario.length)
        if(rvr_lista_usuario.length === 0){
            console.log(rvr_lista_usuario.sqlMessage)
            throw Error('Usuario não encontrado')
        }

        if(rvr_ID > 0){
            
            const [UPD_usuario] = await db.execute(`UPDATE emprestimo set renova = renova - 1, dataemprestimo = CURDATE()  where usuario = '${rvr_CPF}' and id_livro = '${rvr_ID}'`)
            if(!UPD_usuario || UPD_usuario.affectedRows < 1 ){
                console.log(UPD_usuario.sqlMessage)
                throw new Error('Usuario Não possui este livro')
            }

        }
        const [rvr_lista_usuario_livros] = await db.execute(`SELECT lvr.id, lvr.nome, lvr.autor,lvr.volume,lvr.ano, DATE_FORMAT(emp.dataemprestimo,'%d-%m-%Y') dataemprestimo, emp.renova from livro lvr left join emprestimo emp on lvr.id = emp.id_livro where emp.usuario = '${rvr_CPF}';`)


        res.format ({
            html :()=> res.render('renovar_livro',
            {success:'Livro Renovado com sucesso',rvr_lista_usuario:rvr_lista_usuario,rvr_lista_usuario_livros:rvr_lista_usuario_livros,aluno:true,rvr_CPF:rvr_CPF})
        })
        //res.redirect('/teste')
    } catch (error) {
        const [rvr_lista_usuario] = await db.execute(`SELECT nome ,telefone, emal, status, diasbloqueado from usuario where CPF = '${rvr_CPF}';`)
        const [rvr_lista_usuario_livros] = await db.execute(`SELECT lvr.nome, lvr.autor,lvr.volume,lvr.ano, DATE_FORMAT(emp.dataemprestimo,'%d-%m-%Y') dataemprestimo, emp.renova from livro lvr left join emprestimo emp on lvr.id = emp.id_livro where emp.usuario = '${rvr_CPF}';`)
        console.log('este e o erro :' + error.message)
        if (error.message === 'Check constraint \'emprestimo_chk_1\' is violated.'){
            error.message = 'Numero maximo de renovações para este livro foi atingido'
            console.log('estou no if')
        }
        res.format({html: ()=> {
            res.render('renovar_livro', {error:error.message,rvr_lista_usuario:rvr_lista_usuario,rvr_lista_usuario_livros:rvr_lista_usuario_livros,aluno:true,rvr_CPF:rvr_CPF})
             
         }})
        
    }
})






export default router