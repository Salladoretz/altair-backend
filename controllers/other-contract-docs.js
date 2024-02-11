const { prisma } = require('../prisma/prisma-client')


const addOtherContractDocs = async (req, res) => {

    try {
        const data = req.body

        if (!data.contractId) {

            return res.status(400).json({ message: 'Договор не указан!' })

        }

        const partnerId = data.partnerId

        delete data.partnerId

        data.otherDocTypeId ? data.otherDocTypeId = Number(data.otherDocTypeId) : ''
        data.placeId ? data.placeId = Number(data.placeId) : ''
        data.original ? data.original = Boolean(data.original) : ''


        const otherContractDocs = await prisma.otherContractDocs.create({ data })

        otherContractDocs.partnerId = partnerId

        res.status(201).json(otherContractDocs)
    } catch {
        res.status(500).json({ message: 'Не удалось добавить иной документ' })
    }
}


const editOtherContractDocs = async (req, res) => {

    try {
        const data = req.body

        if (!data.contractId) {

            return res.status(400).json({ message: 'Договор не указан!' })

        }

        const partnerId = data.partnerId

        delete data.partnerId

        data.otherDocTypeId ? data.otherDocTypeId = Number(data.otherDocTypeId) : ''
        data.placeId ? data.placeId = Number(data.placeId) : ''
        data.original ? data.original = Boolean(data.original) : ''



        await prisma.otherContractDocs.update({
            where: {
                id: data.id
            },
            data
        })

        const otherContractDocs = await prisma.otherContractDocs.findUnique({
            where: {
                id: data.id
            }
        })

        otherContractDocs.partnerId = partnerId

        res.status(200).json(otherContractDocs)
    } catch {
        res.status(500).json({ message: 'Не удалось отредактировать документ!' })
    }
}


const deleteOtherContractDocs = async (req, res) => {

    try {
        const data = req.body

        await prisma.otherContractDocs.delete({
            where: {
                id: data.id
            }
        })

        res.status(200).json(data)
    } catch {
        res.status(500).json({ message: 'Не удалось удалить документ!' })
    }
}


module.exports = {
    addOtherContractDocs,
    editOtherContractDocs,
    deleteOtherContractDocs
}