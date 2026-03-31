
import express from 'express'
import { fetchSeatOrder, insertSeatOrder } from '../Controller/seat_order_controller';



const SeatOrderRouter = express.Router()

SeatOrderRouter.get('/', fetchSeatOrder)

SeatOrderRouter.post('/', insertSeatOrder)

export default SeatOrderRouter;