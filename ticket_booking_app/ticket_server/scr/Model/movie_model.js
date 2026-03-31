import mongoose from "mongoose";

const movieTable = mongoose.Schema({
    id: {
        type: String,
        unique: true,
        require: true,
    },
    title: {
        type: String,
        require: true,
    },
    description: {
        type: String,
        require: true,
    },
    imageasset: {
        type: String,
        require: true,
   
    },
    imagebanner: {
        type: String,
        require: true,

    },
    favourite: {
        type: Number,
        require: true,
     
    },
    author: {
        type: String,
        require: true,

    },
    category: {
        type: String,
        require: true,
      
    },
    acter: {
        type: String,
        require: true,
      
    },
}, { timestamps: true, versionKey: false})

export default mongoose.model('movieModel', movieTable, 'movie')