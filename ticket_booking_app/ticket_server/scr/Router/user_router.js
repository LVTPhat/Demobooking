

import express from 'express'
import { Authentication } from "../Controller/user_controller";

const UserRouter = express.Router()

UserRouter.post('/', Authentication)


export default UserRouter;