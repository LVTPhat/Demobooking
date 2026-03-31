
import mongoose from "mongoose";


export const connectDB = async (url)=> {
    try {
        await mongoose.connect(url)
        console.log("Connected !")
    } catch (error) {
        console.log('error ' + error);
    }
}