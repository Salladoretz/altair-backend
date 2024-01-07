const express = require('express')
const router = express.Router()
const { check } = require('../controllers/check.js')


router.get('/check', check)

module.exports = router