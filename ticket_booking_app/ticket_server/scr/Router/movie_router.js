import express from 'express';
import multer from 'multer';
import { randomBytes } from 'crypto';
import { deleteMovie, editMovie, fetchMovie, insertMovie } from '../Controller/movie_controller';
import path from 'path';

const upload = multer({
    storage: multer.diskStorage({
        destination: (req, file, cb) => {
            if (file.fieldname === 'file') {
                cb(null,'./scr/assets/movie/avatar');
            } else if (file.fieldname === 'file2') {
                cb(null,'./scr/assets/movie/cover');
            }
        },
        filename: (req, file, cb) => {
            const randomName = randomBytes(10).toString('hex');
            cb(null, `${randomName}${path.extname(file.originalname)}`);
        }
    })
});

const MovieRouter = express.Router();

MovieRouter.get('/', fetchMovie);

MovieRouter.post('/', 
    upload.fields([{ name: 'file', maxCount: 1 }, { name: 'file2', maxCount: 1 }]),
    insertMovie
);
MovieRouter.put('/', 
    upload.fields([{ name: 'file', maxCount: 1 }, { name: 'file2', maxCount: 1 }]),
    editMovie
);
MovieRouter.delete('/', deleteMovie);

export default MovieRouter;
