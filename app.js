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



export default app