const express = require('express')
const router = express.Router()
const { auth } = require('../middleware/auth')
const { login, registration, current } = require('../controllers/users')


router.post('/login', login)

router.post('/registration', registration)

router.get('/current', auth, current)

module.exports = router