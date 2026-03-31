
import mongoose, { version } from "mongoose";

const dateTable = mongoose.Schema({

    id:{
        type: String,
        unique: true,
        require: true
    },
    idMovie:{
        type: String,
        require: true
    },
    name:{
        type: String,
        require: true
    },
}, {timestamps: true, versionKey: false})

export default mongoose.model('dateModel', dateTable, 'date')