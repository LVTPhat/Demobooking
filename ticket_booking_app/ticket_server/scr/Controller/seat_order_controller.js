import seatOrder from "../Model/seat_order"

export const fetchSeatOrder = async (req, res) => {

    try {
        var data = await seatOrder.find()
        return res.status(201).json(data)
    } catch (error) {
        return res.status(500).json(error);
    }

} 

export const insertSeatOrder = async (req, res) => {

    try {
        var data = await seatOrder.create(req.body)
        console.log(data)
        if(data){
            return res.status(201).json({
                status: 1,
                message: "Order Success"
            });
        }
        return res.status(201).json({
            status: 0,
            message: "Order Fail"
        });
      
    } catch (error) {
        return res.status(201).json({
            status: 0,
            message: error.message
        });
    }

} 