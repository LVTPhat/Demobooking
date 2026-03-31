

import mongoose from "mongoose";

const bannerTable = mongoose.Schema({
    id: {
        type: String,
        unique: true,
        require: true
    },
    imageasset: {
        type: String,
        require: true
    }
}, {timestamps: true, versionKey: false})

export default mongoose.model('bannerModel', bannerTable, 'banner')