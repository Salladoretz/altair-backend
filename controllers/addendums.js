const { prisma } = require('../prisma/prisma-client')

/* Добавление дополнительного соглашения
route - POST {BASE_URL}/api/v1/addendum/add
body: addendumNumber, addendumDate, original, cloudCopy, contractId
через модель Contract
*/
const addAddendum = async (req, res) => {

    try {
        const data = req.body

        if (!data.contractId) {

            return res.status(400).json({ message: 'Договор не указан!' })

        }

        const partnerId = data.partnerId

        delete data.partnerId

        data.addendumDate ? data.addendumDate = new Date(data.addendumDate).toISOString() : ''
        data.addendumAmount ? data.addendumAmount = Number(data.addendumAmount) : ''
        data.increaseTotalAmmount ? data.increaseTotalAmmount = Boolean(data.increaseTotalAmmount) : ''
        data.placeId ? data.placeId = Number(data.placeId) : ''
        data.original ? data.original = Boolean(data.original) : ''
        data.status ? data.status = Boolean(data.status) : ''

        const addendum = await prisma.addendum.create({ data })

        addendum.partnerId = partnerId

        res.status(201).json(addendum)
    } catch {
        res.status(500).json({ message: 'Не удалось добавить новое дополнительное соглашение' })
    }
}

/* Редактирование дополнительного соглашения
route - PUT {BASE_URL}/api/v1/addendum/edit
body: id, addendumNumber, addendumDate, original, cloudCopy
*/
const editAddendum = async (req, res) => {

    try {
        const data = req.body

        data.addendumDate ? data.addendumDate = new Date(data.addendumDate).toISOString() : ''
        data.addendumAmount ? data.addendumAmount = Number(data.addendumAmount) : ''
        data.increaseTotalAmmount ? data.increaseTotalAmmount = Boolean(data.increaseTotalAmmount) : ''
        data.placeId ? data.placeId = Number(data.placeId) : ''
        data.original ? data.original = Boolean(data.original) : ''
        data.status ? data.status = Boolean(data.status) : ''

        await prisma.addendum.update({
            where: {
                id: data.id
            },
            data
        })

        const addendum = await prisma.addendum.findUnique({
            where: {
                id: data.id
            }
        })

        addendum.partnerId = data.partnerId

        res.status(200).json(addendum)
    } catch {
        res.status(500).json({ message: 'Не удалось отредактировать дополнительное соглашение!' })
    }
}

/* Удаление дополнительного соглашения
route - DELETE {BASE_URL}/api/v1/addendum/delete
body: id
*/
const deleteAddendum = async (req, res) => {

    try {
        const data = req.body

        await prisma.addendum.delete({
            where: {
                id: data.id
            }
        })

        res.status(200).json(data)
    } catch {
        res.status(500).json({ message: 'Не удалось удалить дополнительное соглашение!' })
    }
}


module.exports = {
    addAddendum,
    editAddendum,
    deleteAddendum
}