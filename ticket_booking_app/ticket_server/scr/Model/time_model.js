
import mongoose, { version } from "mongoose";

const timeTable = mongoose.Schema({

    id:{
        type: String,
        unique: true,
        require: true
    },
    idDate:{
        type: String,
        require: true
    },
    name:{
        type: String,
        require: true
    },
}, {timestamps: true, versionKey: false})

export default mongoose.model('timeModel', timeTable, 'time')