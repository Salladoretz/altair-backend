const express = require('express')
const router = express.Router()
const { auth } = require('../middleware/auth')
const { getAllContracts, getContractById, addContract, editContract, deleteContract } = require('../controllers/contracts')


router.get('/', auth, getAllContracts)
router.get('/:id', auth, getContractById)
router.post('/add', auth, addContract)
router.put('/edit', auth, editContract)
router.delete('/delete', auth, deleteContract)


module.exports = router