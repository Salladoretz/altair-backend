const { prisma } = require('../prisma/prisma-client')

//constractionPlace id is Number!!!

//name, fullAddress, status
const addConstractionPlace = async (req, res) => {

    try {
        const data = req.body

        const constractionPlace = await prisma.constractionPlace.create({
            data: {
                name: data.name,
                fullAddress: data.fullAddress,
                status: Boolean(data.status)
            }
        })

        res.status(201).json(constractionPlace)
    } catch {
        res.status(500).json({ message: 'Не удалось добавить новое место!' })
    }
}


const editConstractionPlace = async (req, res) => {

    try {
        const data = req.body

        await prisma.constractionPlace.update({
            where: {
                id: Number(data.id)
            },
            data: {
                name: data.name,
                fullAddress: data.fullAddress,
                status: Boolean(data.status)
            }
        })

        res.status(200).json({ message: 'Место изменено!' })
    } catch {
        res.status(500).json({ message: 'Не удалось отредактировать место!' })
    }
}

const deleteConstractionPlace = async (req, res) => {

    try {
        const id = Number(req.body.id)

        await prisma.constractionPlace.delete({
            where: {
                id
            }
        })

        res.status(200).json({ message: 'Место удалено!' })
    } catch {
        res.status(500).json({ message: 'Не удалось удалить место!' })
    }
}


module.exports = {
    addConstractionPlace,
    editConstractionPlace,
    deleteConstractionPlace
}