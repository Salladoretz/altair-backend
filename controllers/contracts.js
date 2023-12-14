const { prisma } = require('../prisma/prisma-client')
const bcrypt = require('bcrypt')
const jwt = require('jsonwebtoken')


const getAllContracts = async (req, res) => {

    try {

        const contracts = await prisma.contract.findMany()

        res.status(200).json(contracts)

    } catch {
        res.status(400).json({ message: 'Не удалось загрузить контракты' })
    }
}

const addContract = async (req, res) => {

    try {
        const data = req.body

        if (!data.partnerId) {

            return res.status(400).json({ message: 'Партнер не указан' })

        }

        const contract = await prisma.partner.create({
            data: {
                partnerId: data.partnerId
            }
        })

        res.status(201).json({
            message: 'Контракт добавлен!'
        })
    } catch {
        res.status(500).json({ message: 'Не удалось добавить новый контракт' })
    }
}

module.exports = {
    getAllContracts,
    //getContract,
    addContract,
    //editContract,
    //deleteContract
}