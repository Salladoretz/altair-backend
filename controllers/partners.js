const { prisma } = require('../prisma/prisma-client')
const bcrypt = require('bcrypt')
const jwt = require('jsonwebtoken')


const getAllPartners = async (req, res) => {

    try {

        const partners = await prisma.partner.findMany()

        res.status(200).json(partners)

    } catch {
        res.status(500).json({ message: 'Не удалось загрузить контрагентов' })
    }
}

const getPartnerById = async (req, res) => {

    try {
        const partnerID = req.body.id

        const partner = await prisma.partner.findFirst({
            where: {
                id: id
            }
        })

        res.status(200).json(partner)

    } catch {
        res.status(500).json({ message: 'Не удалось найти контрагента' })
    }
}


const addPartner = async (req, res) => {

    try {
        const data = req.body

        if (!data.name || !data.inn || !data.ogrn) {

            return res.status(400).json({ message: 'Что-то не указано' })

        }

        const partner = await prisma.partner.create({
            data: {
                name: data.name,
                inn: data.inn,
                ogrn: data.ogrn
            }
        })

        res.status(201).json({
            message: 'Контрагент добавлен!'
        })
    } catch {
        res.status(500).json({ message: 'Не удалось добавить нового контрагента' })
    }
}


module.exports = {
    getAllPartners,
    getPartnerById,
    addPartner,
    //editPartner,
    //deletePartner
}