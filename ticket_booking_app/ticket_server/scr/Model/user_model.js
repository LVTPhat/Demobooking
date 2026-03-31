

import mongoose, { version } from "mongoose";

const userTable = mongoose.Schema({
    id: {
        type: String,
        unique: true,
        require: true,
    },
    username: {
        type: String,
        require: true,
    },
    password: {
        type: String,
        require: true,
    },
    permisstion: {
        type: Number,
        require: true,
        default: 0
    },
}, {timestamps: true, versionKey: false})

export default mongoose.model('usersModel', userTable, 'users')