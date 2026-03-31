
import mongoose, { version } from "mongoose";

const seatTable = mongoose.Schema({
    id:{
        type: String,
        unique: true,
        require: true
    },
    username:{
        type: String,
        require: true,
    },
    price:{
        type: Number,
        require: true,
    },
    idSeat:{
        type: String,
        require: true
    },
    idDate:{
        type: String,
        require: true
    },
    idTime:{
        type: String,
        require: true
    },
    idMovie:{
        type: String,
        require: true
    },

}, {timestamps: true, versionKey: false})

export default mongoose.model('seatOrder', seatTable, 'seatorder')