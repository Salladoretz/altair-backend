const { prisma } = require('../prisma/prisma-client')

/* Получение всех договоров
route - GET {BASE_URL}/api/v1/contract
*/
const getAllContracts = async (req, res) => {

    try {
        const contracts = await prisma.contract.findMany()

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
body: contractNumber, contractDate, placeId, original, cloudCopy, partnerId
через модель Partner
*/
const addContract = async (req, res) => {

    try {
        const data = req.body

        if (!data.partnerId) {

            return res.status(400).json({ message: 'Контрагент не указан!' })

        }

        const contract = await prisma.partner.update({
            where: {
                id: data.partnerId
            },
            data: {
                createdContract: {
                    create: {
                        contractNumber: data.contractNumber,
                        contractDate: data.contractDate,
                        placeId: Number(data.placeId),
                        original: Boolean(data.original),
                        cloudCopy: data.cloudCopy
                    }
                }
            }
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

        res.status(200).json({ message: 'Информация о договоре изменена!' })
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
        const { id } = req.body

        await prisma.contract.delete({
            where: {
                id
            }
        })

        res.status(200).json({ message: 'Договор удален!' })
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