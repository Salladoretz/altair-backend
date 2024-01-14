const express = require('express')
const router = express.Router()
const { auth } = require('../middleware/auth')
const { getBaseInfo } = require('../controllers/base-info')


router.get('/', auth, getBaseInfo)

module.exports = router