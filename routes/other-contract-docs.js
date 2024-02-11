const express = require('express')
const router = express.Router()
const { auth } = require('../middleware/auth')
const { addOtherContractDocs, editOtherContractDocs, deleteOtherContractDocs } = require('../controllers/other-contract-docs')


router.post('/add', auth, addOtherContractDocs)
router.put('/edit', auth, editOtherContractDocs)
router.delete('/delete', auth, deleteOtherContractDocs)


module.exports = router