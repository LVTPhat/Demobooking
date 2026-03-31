
import express from 'express'
import { fetchSeat, insertSeat } from '../Controller/seat_controller';


const SeatRouter = express.Router()

SeatRouter.get('/', fetchSeat)

SeatRouter.post('/', insertSeat)

export default SeatRouter;