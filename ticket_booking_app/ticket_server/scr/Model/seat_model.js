
import mongoose, { version } from "mongoose";

const seatTable = mongoose.Schema({
    id:{
        type: String,
        unique: true,
        require: true
    },
    name:{
        type: String,
        require: true
    },
    price:{
        type: Number,
        require: true
    },
}, {timestamps: true, versionKey: false})

export default mongoose.model('seatModel', seatTable, 'seat')