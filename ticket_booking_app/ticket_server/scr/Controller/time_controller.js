import timeModel from "../Model/time_model"

export const fetchTime = async (req, res) => {

    try {
        var data = await timeModel.find()
        return res.status(201).json(data)
    } catch (error) {
        return res.status(500).json(error);
    }

} 

export const insertTime = async (req, res) => {

    try {
        var data = await timeModel.create(req.body)
        return res.status(201).json(data)
    } catch (error) {
        return res.status(500).json(error);
    }

} 