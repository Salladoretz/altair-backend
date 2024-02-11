const express = require('express')
const cookieParser = require('cookie-parser')
const logger = require('morgan')
const cors = require('cors')

require('dotenv').config()

const app = express()

app.use(logger('dev'))
app.use(cors())
app.use(express.json())
app.use(express.urlencoded({ extended: false }))
app.use(cookieParser())

app.use('/', require('./routes/check'))
app.use('/api/v1/user', require('./routes/users'))
app.use('/api/v1/base-info', require('./routes/base-info'))
app.use('/api/v1/partner', require('./routes/partners'))
app.use('/api/v1/contract', require('./routes/contracts'))
app.use('/api/v1/addendum', require('./routes/addendums'))
app.use('/api/v1/othercontractdoc', require('./routes/other-contract-docs'))
app.use('/api/v1/constractionplace', require('./routes/constractionPlace'))

module.exports = app