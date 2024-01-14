const { prisma } = require('../prisma/prisma-client')


const getBaseInfo = async (req, res) => {
    try {

        const data = {}

        const contractTypes = await prisma.contractTypes.findMany()
        data.contractTypes = contractTypes

        const otherDocTypes = await prisma.otherDocTypes.findMany()
        data.otherDocTypes = otherDocTypes

        const constractionPlace = await prisma.constractionPlace.findMany()
        data.constractionPlace = constractionPlace


        res.status(200).json(data)

    } catch {
        res.status(400).json({ message: 'Что-то пошло не так' })
    }

}



module.exports = {
    getBaseInfo
}