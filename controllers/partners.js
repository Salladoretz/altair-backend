const { prisma } = require('../prisma/prisma-client')
const bcrypt = require('bcrypt')
const jwt = require('jsonwebtoken')


const getAllPartners = async (req, res) => {

    try {

        const partners = await prisma.partner.findMany()

        res.status(200).json(partners)

    } catch {
        res.status(400).json({ message: 'Не удалось загрузить контрагентов' })
    }
}

module.exports = {
    getAllPartners,
    getPartner,
    addPartner,
    editPartner,
    deletePartner
}