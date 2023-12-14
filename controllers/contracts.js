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

module.exports = {
    getAllContracts,
    //getContract,
    //addContract,
    //editContract,
    //deleteContract
}