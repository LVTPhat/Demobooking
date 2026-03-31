import usersModel from "../Model/user_model";
import bcrypt from 'bcrypt'

export const Authentication = async (req, res) => {
    try {
        console.log(req.body)
        const {id, status, username, password, repassword} = req.body;
        // Login
        if(status == 0){
            const result = await usersModel.findOne({username: username})            
            if(result){               
                const check = await bcrypt.compare(password, result.password)
                console.log("UserLogin: " + check)       
                if(check){
                    return res.status(201).json({
                        status: 1,
                        message: "Login Success",
                        users: {
                            id: result.id,
                            username: result.username,
                            permisstion: result.permisstion
                        }
                    });
                }
                return res.status(201).json({
                    status: 0,
                    message: "Mật khẩu ko đúng",    
                    users:{}               
                });
            }    
            return res.status(201).json({
                status: 0,
                message: "Tài khoản không tồn tại",     
                users:{}     
            })
        }
        if(status == 1){
            
            if(repassword != password){
                return res.status(201).json({
                    status: 0,
                    message: "Mật khẩu nhập lại ko trùng khớp",          
                })
            }
            const data = await usersModel.find({username: username})
            if(data.length > 0){
                return res.status(201).json({
                    status: 0,
                    message: "Tài khoản tồn tại",          
                })
            }else{
                const passBcypt = await bcrypt.hash(password, 5)
                const insertData = {
                    id: id,
                    username: username,
                    password: passBcypt,
                    permisstion: 0
                }       
                const result = await usersModel.create(insertData)            
                if(result){
                    return res.status(201).json({
                        status: 0,
                        message: "Register Success",
                        users: {
                            id: result.id,
                            username: result.username,
                            permisstion: result.permisstion
                        }
                    });
                }    
                return res.status(201).json({
                    status: 0,
                    message: "Register Fail",          
                })
            }

        }
        
    } catch (error) {
        return res.status(201).json({
            status: 0,
            message: error.message,          
        })
    }
}