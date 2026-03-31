import movieModel from '../Model/movie_model'
import dateModel from '../Model/datetime_model'
export const fetchMovie = async (req, res) =>{
    
    try {
        const data = await movieModel.find();
        return res.status(201).json(data);
    } catch (error) {
        res.status(500).json(error)
    }
}

export const insertMovie = async (req, res) => {
    try {

        const value = JSON.parse(req.body.data)
        if(!req.files){
            return res.status(201).json({
                status: 0,
                message: "Có lỗi xảy ra"
            })
        }
        const avatarFile = req.files['file'] ? req.files['file'][0] : null;
        const coverFile = req.files['file2'] ? req.files['file2'][0] : null;
        var avatarPath, coverPath;
        if (avatarFile) {
            avatarPath = avatarFile.path.replace('scr\\assets\\', '');
        }
        if (coverFile) {
            coverPath = coverFile.path.replace('scr\\assets\\', '');
        }
        const dataInsert = [{
            ...value,
            imageasset: avatarPath,
            imagebanner: coverPath
        }]
        console.log(dataInsert)
        const insertMovie = await movieModel.create(dataInsert)
        if(insertMovie){      
            return res.status(201).json({
                status: 1,
                message: "Add Movie Success!"
            });
        }
        return res.status(201).json({
            status: 0,
            message: "Error Insert Movie"
        })

    } catch (error) {
        return res.status(201).json({
            status: 0,
            message: error.message,
        }); 
    }
}


export const deleteMovie = async (req, res) =>{

    try {
        console.log(req.body)
        const {id} = req.body;

        const data = await movieModel.findOneAndDelete({ id: id });
        if(data){
            return res.status(201).json({
                status: 1,
                message: 'Delete Success'
            })
        }
        return res.status(201).json({
            status: 0,
            message: 'Delete Error'
        })
        
    } catch (error) {
        return res.status(201).json({
            status: 0,
            message: error.message,
        }); 
    }
} 

export const editMovie = async (req, res) => {
    try {

        const value = JSON.parse(req.body.data)
        const idmovie = value.id
        console.log(idmovie);
        var avatarPath, coverPath;
        if(req.files){
            const avatarFile = req.files['file'] ? req.files['file'][0] : null;
            const coverFile = req.files['file2'] ? req.files['file2'][0] : null;
            
            if (avatarFile) {
                avatarPath = avatarFile.path.replace('scr\\assets\\', '');
            }
            if (coverFile) {
                coverPath = coverFile.path.replace('scr\\assets\\', '');
            }
        }
        var dataInsert = {
            ...value
        }
        if (avatarPath) {
            dataInsert.imageasset = avatarPath;
        }
        if (coverPath) {
            dataInsert.imagebanner = coverPath;
        }
        console.log(dataInsert)
        const result = await movieModel.findOneAndUpdate(
            {id: idmovie},
            dataInsert,
            {new: true}
        )
        if(result){
            return res.status(201).json({
                status: 1,
                message: "Edit Success",
            }); 
        }
        return res.status(201).json({
            status: 0,
            message: "Edit Fail",
        }); 

    } catch (error) {
        return res.status(201).json({
            status: 0,
            message: error.message,
        }); 
    }

}