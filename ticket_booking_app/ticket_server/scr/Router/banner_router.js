
import express from 'express'
import { fetchBanner, insertBanner } from '../Controller/banner_controller';

const BannerRouter = express.Router()

BannerRouter.get('/', fetchBanner)

BannerRouter.post('/', insertBanner)

export default BannerRouter;