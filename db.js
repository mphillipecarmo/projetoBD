import mysql from 'mysql2/promise'

const pool = mysql.createPool({
  // configuração de acesso
  host: '127.0.0.1',
  database: 'biblioteca',
  user: 'root',
  password: '123456',
  port: 33060,

  // configuração das conexões
  multipleStatements: true,

  // configuração da pool
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
})

export default pool