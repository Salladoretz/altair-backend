const express = require('express')
const router = express.Router()


router.get('/check', function (req, res) { res.send('Still alive!') })

module.exports = router