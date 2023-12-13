const express = require('express')
const router = express.Router()
const { auth } = require('../middleware/auth')


router.get('/', auth, getAllContracts)
router.get('/:id', auth, getContract)
router.post('/add', auth, addContract)
router.put('/edit/:id', auth, editContract)
router.delete('/delete/:id', auth, deleteContract)


module.exports = router