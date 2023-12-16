const express = require('express')
const router = express.Router()
const { auth } = require('../middleware/auth')
const { addAddendum, editAddendum, deleteAddendum } = require('../controllers/addendums')


router.post('/add', auth, addAddendum)
router.put('/edit', auth, editAddendum)
router.delete('/delete', auth, deleteAddendum)


module.exports = router