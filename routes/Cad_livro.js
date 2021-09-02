import express from 'express'
import { nextTick } from 'process';
import db from '../db.js'

const router = express.Router()


/* GET página inicial */
router.get('/',async (req, res, next)=>{
    res.render('Cad_livro',{funcionario:true})


})

router.post('/',async (req, res, next)=>{
    const { cad_nomelivro, cad_nomeAutor, cad_nomeEditora,cad_volume,cad_edicao,cad_categoria,cad_descricao,cad_ano,cad_quantidade} = req.body;

    console.log(req.body)
    try {
        console.log(cad_nomelivro + ' ' + cad_nomeAutor + ' ' + cad_nomeEditora + ' ' + cad_volume + ' ' + cad_edicao+ ' ' + cad_categoria + ' ' + cad_descricao +' ' + cad_ano +' ' + cad_quantidade)
        const [livro] = await db.execute(`INSERT INTO livro VALUES (0,'${cad_nomelivro}','${cad_nomeAutor}','${cad_nomeEditora}','${cad_volume}','${cad_edicao}','${cad_categoria}','${cad_descricao}','${cad_ano}','${cad_quantidade}')`)
        console.log(livro)
        
        if(!livro || livro.affectedRows < 1 ){
            throw new Error('Livro não foi inserido corretamente')
        }
        res.format({html: ()=> {
            res.render('Cad_livro', {success:'Livro cadastrado com sucesso'})
             
         }})
        
        //res.redirect('/teste')
    } catch (error) {

        console.log(error)
        res.format({html: ()=> {
            res.render('Cad_livro', {error:error.message})
             
         }})
    }
})

export default router