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

        const addendum = await prisma.contract.update({
            where: {
                id: data.contractId
            },
            data: {
                createdAddendum: {
                    create: {
                        addendumNumber: data.addendumNumber,
                        addendumDate: data.addendumDate,
                        original: Boolean(data.original),
                        cloudCopy: data.cloudCopy
                    }
                }
            }
        })

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

        await prisma.addendum.update({
            where: {
                id: data.id
            },
            data: {
                addendumNumber: data.addendumNumber,
                addendumDate: data.addendumDate,
                original: Boolean(data.original),
                cloudCopy: data.cloudCopy
            }
        })

        res.status(200).json({ message: 'Дополнительное соглашение изменено!' })
    } catch {
        res.status(500).json({ message: 'Не удалось отредактировать дополнительное соглашение!' })
    }
}

/* Удаление договора
route - DELETE {BASE_URL}/api/v1/addendum/delete
body: id
*/
const deleteAddendum = async (req, res) => {

    try {
        const { id } = req.body

        await prisma.addendum.delete({
            where: {
                id
            }
        })

        res.status(200).json({ message: 'Дополнительное соглашение удалено!' })
    } catch {
        res.status(500).json({ message: 'Не удалось удалить дополнительное соглашение!' })
    }
}


module.exports = {
    addAddendum,
    editAddendum,
    deleteAddendum
}