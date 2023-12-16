const express = require('express')
const router = express.Router()
const { auth } = require('../middleware/auth')
const { getAllPartners, getPartnerById, addPartner, editPartner, deletePartner } = require('../controllers/partners')


router.get('/', auth, getAllPartners)
router.get('/:id', auth, getPartnerById)
router.post('/add', auth, addPartner)
router.put('/edit', auth, editPartner)
router.delete('/delete', auth, deletePartner)


module.exports = router