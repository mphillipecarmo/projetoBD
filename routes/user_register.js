import express from 'express'
import { nextTick } from 'process';
import db from '../db.js'

const router = express.Router()


/* GET página inicial */
router.get('/',async (req, res, next)=>{
    res.render('user_register')


})

router.post('/',async (req, res, next)=>{
    const { nomeUsuario, CPF, Telefone,emailUsuario,endereco,Switch_aluno,matricula_aluno } = req.body;

    
    try {
        console.log(nomeUsuario + ' ' + CPF + ' ' + Telefone + ' ' + emailUsuario + ' ' + endereco)
        const [user] = await db.execute(`INSERT INTO usuario VALUES ('${nomeUsuario}','${CPF}','${Telefone}','${emailUsuario}','ok')`)
        console.log(user)
        if(Switch_aluno.checked){
            const [aluno] = await db.execute(`INSERT INTO aluno VALUES ('${CPF}','${matricula_aluno}')`)
        }else{
            const [aluno] = await db.execute(`INSERT INTO aluno VALUES (0,'${matricula_aluno}')`)
        }

        if(!user || user.affectedRows < 1 ){
            throw new Error('Usuário não foi inserido corretamente')
        }
        
        res.format({
            html: ()=>{req.flash('success',"Usuario cadastrado com sucesso")
            res.redirect('/')
        },
        json:()=> res.status(200).send({})
        })
        
        //res.redirect('/teste')
    } catch (error) {

        console.log(error)
    }
})

//VALUES (${nomeUsuario},${CPF},${Telefone},${emailUsuario},${endereco})`
export default router