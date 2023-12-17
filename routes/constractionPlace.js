const express = require('express')
const router = express.Router()
const { auth } = require('../middleware/auth')
const { addConstractionPlace, editConstractionPlace, deleteConstractionPlace } = require('../controllers/constractionPlace')


router.post('/add', auth, addConstractionPlace)
router.put('/edit', auth, editConstractionPlace)
router.delete('/delete', auth, deleteConstractionPlace)


module.exports = router