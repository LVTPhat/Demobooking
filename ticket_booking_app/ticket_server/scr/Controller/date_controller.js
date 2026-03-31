import dateModel from "../Model/datetime_model"

export const fetchDate = async (req, res) => {

    try {
        var data = await dateModel.find()
        return res.status(201).json(data)
    } catch (error) {
        return res.status(500).json(error);
    }

} 

export const insertDate = async (req, res) => {

    try {
        var data = await dateModel.create(req.body)
        return res.status(201).json(data)
    } catch (error) {
        return res.status(500).json(error);
    }

} 