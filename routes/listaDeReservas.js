import express from 'express'
import db from '../db.js'

const router = express.Router()


/* GET página inicial */

router.get('/',async (req, res, next)=>{
    try {
        
        const [reserva] = await db.execute(`select res.nome,res.usuario as CPF, lvr.nome as livro, lvr.id, res.status, DATE_FORMAT(res.data,'%d-%m-%Y') data from reserva_nome res inner join livro lvr on lvr.id = res.id_livro order by res.data`)
        //let temp = Object.entries(pendente)
        console.log(reserva)
        res.format ({
            html :()=> res.render('listaDeReservas',{reserva:reserva,funcionario:true}),
            json: () => res.json({reserva})
        })
        
    } catch (error) {
        console.log(error)
    }

})

export default router