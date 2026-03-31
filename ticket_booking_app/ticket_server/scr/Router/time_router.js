
import express from 'express'
import { fetchTime, insertTime } from '../Controller/time_controller';

const TimeRouter = express.Router()

TimeRouter.get('/', fetchTime)

TimeRouter.post('/', insertTime)

export default TimeRouter;