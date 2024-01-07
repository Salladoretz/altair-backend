const check = async (res) => {
    try {
        return res.status(200).json({ message: 'Still alive!' })

    } catch {
        res.status(400).json({ message: 'Что-то пошло не так' })
    }
}

module.exports = {
    check
}