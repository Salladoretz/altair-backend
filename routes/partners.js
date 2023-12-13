const express = require('express')
const router = express.Router()
const { auth } = require('../middleware/auth')


router.get('/', auth, getAllPartners)
router.get('/:id', auth, getPartner)
router.post('/add', auth, addPartner)
router.put('/edit/:id', auth, editPartner)
router.delete('/delete/:id', auth, deletePartner)


module.exports = router