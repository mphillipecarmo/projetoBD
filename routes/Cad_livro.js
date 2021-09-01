import express from 'express'
import { nextTick } from 'process';
import db from '../db.js'

const router = express.Router()


/* GET página inicial */
router.get('/',async (req, res, next)=>{
    res.render('Cad_livro')


})

router.post('/',async (req, res, next)=>{
    const { nomelivro, nomeAutor, nomeEditora,volume,edicao,categoria,descricao,ano,quantidade} = req.body;

    console.log(req.body)
    try {
        console.log(nomelivro + ' ' + nomeAutor + ' ' + nomeEditora + ' ' + volume + ' ' + edicao+ ' ' + categoria + ' ' + descricao +' ' + ano +' ' + quantidade)
        const [livro] = await db.execute(`INSERT INTO livro VALUES (0,'${nomelivro}','${nomeAutor}','${nomeEditora}','${volume}','${edicao}','${categoria}','${descricao}','${ano}','${quantidade}')`)
        console.log(livro)
        
        if(!livro || livro.affectedRows < 1 ){
            throw new Error('Livro não foi inserido corretamente')
        }
        res.send({ok:true})
        
        //res.redirect('/teste')
    } catch (error) {

        console.log(error)
    }
})

export default router