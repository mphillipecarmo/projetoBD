// módulos da plataforma
import path from 'path'

// módulos npm
import express from 'express'
import hbs from 'hbs'
import logger from 'morgan'
import session from 'express-session'
import methodOverride from 'method-override'
import flash from 'connect-flash'





// a definição das rotas de cada "entidade" está isolada em seu próprio arquivo
// de forma a tornar o código do projeto organizado
import EmprestarLivro from './routes/EmprestarLivro.js'
import index from './routes/index.js'
import list_pendencia from './routes/list_pendencia.js'
import list_status from './routes/list_status.js'
import user_register from './routes/user_register.js'
import Devolver_livro from './routes/Devolver_livro.js'
import Cad_livro from './routes/Cad_livro.js'

import renovar_livro from './routes/renovar_livro.js'
import reservar_livro from './routes/reservar_livro.js'
import consultar_datas from './routes/consultar_datas.js'
import listaDeLivros from './routes/listaDeLivros.js'
import lista_ultimoDia from './routes/lista_ultimoDia.js'

import index_aluno from './routes/index_aluno.js'
import listaDeLivros_aluno from './routes/listaDeLivros_aluno.js'


const app = express()
const __dirname = new URL('.', import.meta.url).pathname

// configura a pasta que contém as views e o handlebars como templating engine
app.set('views', `${__dirname}/views`)
app.set('view engine', 'hbs')
hbs.registerPartials(`${__dirname}/views/partials`, console.error)
app.set('json spaces', 2);

// possibilita enviar um DELETE via formulário,
// quando é um POST com ?_method=DELETE na querystring
//
// isto é necessário porque formulários aceitam apenas GET e POST
app.use(methodOverride('_method', { methods: ['GET', 'POST'] }))
app.use(logger('dev'))                                    // registra tudo no terminal
app.use(express.json())                                   // necessário pra POST, PUT, PATCH etc.
app.use(express.urlencoded({ extended: false }))
app.use(session({                                         // necessário para flash()
  secret: 'lalala',
  resave: false,
  saveUninitialized: true
}))
app.use(flash())                                          // necessário para msgs efêmeras
app.use(express.static(path.join(__dirname, 'public')))   // serve arquivos estáticos


// configura as rotas "de cada entidade" da aplicação (separadinho, organizado)
app.use('/', index)
app.use('/user_register', user_register)
app.use('/list_status', list_status)
app.use('/list_pendencia', list_pendencia)
app.use('/EmprestarLivro', EmprestarLivro)
app.use('/Devolver_livro', Devolver_livro)
app.use('/Cad_livro', Cad_livro)

app.use('/renovar_livro', renovar_livro)
app.use('/reservar_livro', reservar_livro)
app.use('/consultar_datas', consultar_datas)
app.use('/listaDeLivros', listaDeLivros)
app.use('/lista_ultimoDia', lista_ultimoDia)

app.use('/index_aluno', index_aluno)
app.use('/listaDeLivros_aluno', listaDeLivros_aluno)

if (app.get('env') === 'development') {
  app.use((err, req, res, next) => {
    const message = err.friendlyMessage ? [err.friendlyMessage, err.message].join('. ') : err.message
    res.status(err.status || 500)
    res.render('error', {
      message: message,
      error: err
    })
  })
}

// handler de erros de ambiente de produção
// não mostra a stack de erros pro usuário
app.use((err, req, res, next) => {
  res.status(err.status || 500)
  res.render('error', {
    message: err.friendlyMessage ?? err.message,
    error: {}
  })
})
// uma rota "catch-all" para erros de caminho inexistente
app.use((req, res, next) => {
  const err = new Error('Not Found')
  err.status = 404
  next(err)
})

// handler de erros em ambientes de dev
// imprime a stacktrace
if (app.get('env') === 'development') {
  app.use((err, req, res, next) => {
    const message = err.friendlyMessage ? [err.friendlyMessage, err.message].join('. ') : err.message
    res.status(err.status || 500)
    res.render('error', {
      message: message,
      error: err
    })
  })
}

// handler de erros de ambiente de produção
// não mostra a stack de erros pro usuário
app.use((err, req, res, next) => {
  res.status(err.status || 500)
  res.render('error', {
    message: err.friendlyMessage ?? err.message,
    error: {}
  })
})

export default app