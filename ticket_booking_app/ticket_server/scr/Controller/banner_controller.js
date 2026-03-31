import bannerModel from "../Model/banner_model"

export const fetchBanner = async (req, res) => {

    try {
        var data = await bannerModel.find()
        return res.status(201).json(data)
    } catch (error) {
        return res.status(500).json(error);
    }

} 

export const insertBanner = async (req, res) => {

    try {
        var data = await bannerModel.create(req.body)
        return res.status(201).json(data)
    } catch (error) {
        return res.status(500).json(error);
    }

} 