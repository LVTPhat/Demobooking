
export function configureMulter(path) {
    const storage = multer.diskStorage({
      destination: (req, file, cb) => {
        cb(null, 'src/assets/' + path); 
      },
      filename: (req, file, cb) => {
        const randomName = randomBytes(10).toString('hex') + '.' + file.originalname.split('.').pop();
            cb(null, randomName); 
      },
    });
    return multer({ storage });
}