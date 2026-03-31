
import express from 'express'
import { fetchDate, insertDate } from '../Controller/date_controller';

const DateRouter = express.Router()

DateRouter.get('/', fetchDate)

DateRouter.post('/', insertDate)

export default DateRouter;