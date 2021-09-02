import express from 'express'
import db from '../db.js'

const router = express.Router()


router.get('/',async (req, res, next)=>{
    try {
        
        const [livro] = await db.execute(`SELECT * from livro`)
        //let temp = Object.entries(pendente)
        console.log(livro)
        res.format ({
            html :()=> res.render('reservar_livro',{livro:livro,aluno:true}),
            json: () => res.json({livro})
        })
        
    } catch (error) {
        console.log(error)
    }

})

router.post('/',async (req, res, next)=>{
    const { rev_id_livro, rev_CPF} = req.body;
    console.log(rev_id_livro + ' ' + rev_CPF)
    try {
        const [livro] = await db.execute(`SELECT * from livro`)
        const [reservas] = await db.execute(`INSERT INTO reservas VALUES ('${rev_CPF}','${rev_id_livro}',CURDATE(),'Aguardando')`)
        console.log(reservas)
        if(!reservas || reservas.affectedRows < 1 ){
            console.log(reservas.sqlMessage)
            throw new Error('Reserva não foi inserido corretamente')
        }
        console.log('Livro reservado com sucesso')
        res.format({html: ()=> {
            res.render('reservar_livro', {success:'Livro reservardo com sucesso',livro:livro,aluno:true})
             
         }})

        //res.redirect('/teste')
    } catch (error) {

        console.log(error)
        const [livro] = await db.execute(`SELECT * from livro`)
        res.format({html: ()=> {
            res.render('reservar_livro', {error:error.message,livro:livro,aluno:true})
             
         }})
    }
})



export default router