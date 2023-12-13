const { prisma } = require('../prisma/prisma-client')
const bcrypt = require('bcrypt')
const jwt = require('jsonwebtoken')

const login = async (req, res) => {
    try {

        const { nickname, password } = req.body

        if (!nickname || !password) {
            return res.status(400).json({ message: 'Пустое поле!' })
        }

        const user = await prisma.user.findFirst({
            where: {
                nickname: nickname
            }
        })

        const isPasswordCorrect = user && (await bcrypt.compare(password, user.password))
        const secret = process.env.JWT_SECRET

        if (user && isPasswordCorrect && secret) {
            res.status(200).json({
                id: user.id,
                nickname: user.nickname,
                name: user.name,
                token: jwt.sign({ id: user.id }, secret, { expiresIn: '30d' })
            })
        } else {
            return res.status(400).json({ message: 'Неверно введен логин или пароль!' })
        }
    } catch {
        res.status(400).json({ message: 'Что-то пошло не так' })
    }

}

const register = async (req, res) => {

    try {
        const { nickname, password } = req.body

        if (!nickname || !password) {
            return res.status(400).json({ message: 'Пустые поля!' })
        }

        const registeredUser = await prisma.user.findFirst({
            where: {
                nickname: nickname
            }
        })

        if (registeredUser) {
            return res.status(400).json({ message: 'Такой пользователь существует' })
        }

        const salt = await bcrypt.genSalt(8)
        const hashedPassword = await bcrypt.hash(password, salt)

        const user = await prisma.user.create({
            data: {
                nickname: nickname,
                password: hashedPassword
            }
        })

        const secret = process.env.JWT_SECRET

        if (user && secret) {
            res.status(201).json({
                id: user.id,
                nickname: user.nickname,
                name: user.name,
                token: jwt.sign({ id: user.id }, secret, { expiresIn: '30d' })
            })
        } else {
            return res.status(400).json({ message: 'Вас не удалось зарегистрировать' })
        }
    } catch {
        res.status(400).json({ message: 'Что-то пошло не так' })
    }

}

const current = async (req, res) => {
    res.status(200).json(req.user)
}

module.exports = {
    login,
    register,
    current
}