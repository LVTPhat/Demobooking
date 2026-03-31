import seatModel from "../Model/seat_model"

export const fetchSeat = async (req, res) => {

    try {
        var data = await seatModel.find()
        return res.status(201).json(data)
    } catch (error) {
        return res.status(500).json(error);
    }

} 

export const insertSeat = async (req, res) => {

    try {
        var data = await seatModel.create(req.body)
        return res.status(201).json(data)
    } catch (error) {
        return res.status(500).json(error);
    }

} 