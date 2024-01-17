const { prisma } = require('../prisma/prisma-client')

/* Получение всех контрагентов
route - GET {BASE_URL}/api/v1/partner
*/
const getAllPartners = async (req, res) => {

    try {
        const partners = await prisma.partner.findMany(
            {
                include: {
                    createdContract: {
                        include: {
                            place: {
                                select: {
                                    name: true
                                }
                            },
                            contractType: {
                                select: {
                                    title: true
                                }
                            },
                            partner: {
                                select: {
                                    shortName: true
                                }
                            },
                            createdAddendum: {
                                include: {
                                    place: {
                                        select: {
                                            name: true
                                        }
                                    },
                                    contract: {
                                        select: {
                                            contractNumber: true,
                                            contractDate: true,
                                            partner: {
                                                select: {
                                                    shortName: true
                                                }
                                            }

                                        }
                                    },
                                    createdOtherAddendumDocs: {
                                        include: {
                                            otherDocType: {
                                                select: {
                                                    title: true
                                                }
                                            }
                                        }
                                    }
                                }
                            },
                            createdOtherContractDocs: {
                                include: {
                                    otherDocType: {
                                        select: {
                                            title: true
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

            }

        )

        res.status(200).json(partners)

    } catch {
        res.status(500).json({ message: 'Не удалось загрузить контрагентов!' })
    }
}

/* Получение контрагента по ID
route - GET {BASE_URL}/api/v1/partner/:id
С помощью params
*/
const getPartnerById = async (req, res) => {

    try {
        const { id } = req.params

        const partner = await prisma.partner.findUnique({
            where: {
                id
            }
        })

        res.status(200).json(partner)

    } catch {
        res.status(500).json({ message: 'Не удалось получить информацию о контрагенте!' })
    }
}

/* Добавление контрагента
route - POST {BASE_URL}/api/v1/partner/add
body: name, shortName, ogrn, ogrnDate, inn, address1, address2, email, phone, bank, boss
*/
const addPartner = async (req, res) => {

    try {
        const data = req.body

        if (!data.name || !data.inn) {

            return res.status(400).json({ message: 'Что-то  важное не указано' })

        }

        if (data.ogrnDate) {
            data.ogrnDate = new Date(data.ogrnDate).toISOString()
        }

        const partner = await prisma.partner.create({
            data
        })

        partner.createdContract = []

        res.status(201).json(partner)
    } catch {
        res.status(500).json({ message: 'Не удалось добавить нового контрагента!' })
    }
}

/* Редактирование контрагента
route - PUT {BASE_URL}/api/v1/partner/edit
body: id, name, shortName, ogrn, ogrnDate, inn, address1, address2, email, phone, bank, boss, bossGenitive
*/
const editPartner = async (req, res) => {

    try {
        const data = req.body

        if (data.ogrnDate) {
            data.ogrnDate = new Date(data.ogrnDate).toISOString()
        }

        await prisma.partner.update({
            where: {
                id: data.id
            },
            data
        })

        res.status(200).json(data)
    } catch {
        res.status(500).json({ message: 'Не удалось отредактировать информацию о контрагенте!' })
    }
}

/* Удаление контрагента
route - DELETE {BASE_URL}/api/v1/partner/delete
body: id
*/
const deletePartner = async (req, res) => {

    try {
        const { id } = req.body

        await prisma.partner.delete({
            where: {
                id
            }
        })

        res.status(200).json(id)
    } catch {
        res.status(500).json({ message: 'Не удалось удалить контрагента!' })
    }
}


module.exports = {
    getAllPartners,
    getPartnerById,
    addPartner,
    editPartner,
    deletePartner
}