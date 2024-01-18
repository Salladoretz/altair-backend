const { prisma } = require('../prisma/prisma-client')

/* Получение всех договоров
route - GET {BASE_URL}/api/v1/contract
*/
const getAllContracts = async (req, res) => {

    try {
        const contracts = await prisma.contract.findMany({
            select: {
                id: true,
                contractNumber: true,
                contractDate: true,
                place: true,
                original: true,
                cloudCopy: true,
                partner: true,
                createdAddendum: true
            }
        })

        res.status(200).json(contracts)

    } catch {
        res.status(500).json({ message: 'Не удалось загрузить договоры' })
    }
}

/* Получение договора по ID
route - GET {BASE_URL}/api/v1/contract/:id
С помощью params
*/
const getContractById = async (req, res) => {

    try {
        const { id } = req.params

        const contract = await prisma.contract.findUnique({
            where: {
                id
            }
        })

        res.status(200).json(contract)

    } catch {
        res.status(500).json({ message: 'Не удалось получить информацию о договоре!' })
    }
}

/* Добавление договора
route - POST {BASE_URL}/api/v1/contract/add
*/
const addContract = async (req, res) => {

    try {
        const data = req.body

        if (!data.partnerId) {

            return res.status(400).json({ message: 'Контрагент не указан!' })

        }

        data.contractTypeId ? data.contractTypeId = Number(data.contractTypeId) : ''
        data.contractDate ? data.contractDate = new Date(data.contractDate).toISOString() : ''
        data.contractAmount ? data.contractAmount = Number(data.contractAmount) : ''
        data.contractPeriod ? data.contractPeriod = new Date(data.contractPeriod).toISOString() : ''
        data.contractMaterials ? data.contractMaterials = Boolean(data.contractMaterials) : ''
        data.placeId ? data.placeId = Number(data.placeId) : ''
        data.original ? data.original = Boolean(data.original) : ''
        data.status ? data.status = Boolean(data.status) : ''


        const contract = await prisma.contract.create({
            data
        })

        res.status(201).json(contract)
    } catch {
        res.status(500).json({ message: 'Не удалось добавить новый договор' })
    }
}

/* Редактирование договора
route - PUT {BASE_URL}/api/v1/contract/edit
body: id, contractNumber
*/
const editContract = async (req, res) => {

    try {
        const data = req.body

        await prisma.contract.update({
            where: {
                id: data.id
            },
            data
        })

        res.status(200).json(data)
    } catch {
        res.status(500).json({ message: 'Не удалось отредактировать информацию о договоре!' })
    }
}

/* Удаление договора
route - DELETE {BASE_URL}/api/v1/contract/delete
body: id
*/
const deleteContract = async (req, res) => {

    try {
        const data = req.body

        await prisma.contract.delete({
            where: {
                id: data.id
            }
        })

        res.status(200).json(data)
    } catch {
        res.status(500).json({ message: 'Не удалось удалить договор!' })
    }
}


module.exports = {
    getAllContracts,
    getContractById,
    addContract,
    editContract,
    deleteContract
}