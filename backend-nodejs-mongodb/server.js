const express = require('express')
const cors = require('cors');
const mongoose = require('mongoose')
const multer = require('multer')
const Product = require('./models/productModel')
const app = express()
require('dotenv').config();
const mongodbUri = process.env.MONGODB_URI;

const storage = multer.memoryStorage(); // Use memory storage for storing the file as a Buffer
const upload = multer({ storage: storage });

app.use(express.json())
app.use(cors());
app.use(express.urlencoded({extended: false}))

//routes

app.get('/', (req, res) => {
    res.send('Hello NODE API')
})


app.get('/products', async(req, res) => {
    try {
        const products = await Product.find();
        res.status(200).json(products); 
    } catch (error) {
        res.status(500).json({message: error.message})
    }
})

app.get('/products/:id', async(req, res) =>{
    try {
        const {id} = req.params;
        const product = await Product.findById(id);
        res.status(200).json(product);
    } catch (error) {
        res.status(500).json({message: error.message})
    }
})


// app.post('/products', async (req, res) => {
//     try {
//         console.log('Received request body:', req.body);
//         const product = await Product.create(req.body);
//         res.status(200).json(product);
//     } catch (error) {
//         console.log(error.message);
//         res.status(500).json({ message: error.message });
//     }
// })


app.post('/products', upload.single('image'), async (req, res) => {
    try {
        console.log('Received request body:', req.body);
        // Access the uploaded file from req.file
        const imageBuffer = req.file.buffer;

        // Assuming you have a field 'image' in your product model, update the create method
        const product = await Product.create({
            ...req.body,
            image: imageBuffer, // Save the image buffer in the 'image' field
        });

        res.status(200).json(product);
    } catch (error) {
        console.log(error.message);
        res.status(500).json({ message: error.message });
    }
});


// update a product
app.put('/products/:id', async(req, res) => {
    try {
        const {id} = req.params;
        const product = await Product.findByIdAndUpdate(id, req.body);
        // we cannot find any product in database
        if(!product){
            return res.status(404).json({message: `cannot find any product with ID ${id}`})
        }
        const updatedProduct = await Product.findById(id);
        res.status(200).json(updatedProduct);
        
    } catch (error) {
        res.status(500).json({message: error.message})
    }
})

// delete a product

app.delete('/products/:id', async(req, res) =>{
    try {
        const {id} = req.params;
        const product = await Product.findByIdAndDelete(id);
        if(!product){
            return res.status(404).json({message: `cannot find any product with ID ${id}`})
        }
        res.status(200).json(product);
        
    } catch (error) {
        res.status(500).json({message: error.message})
    }
})


mongoose.set("strictQuery", false)
mongoose.
connect(process.env.MONGODB_URI, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
})
.then(() => {
    console.log('connected to MongoDB')
    app.listen(3000, ()=> {
        console.log(`Node API app is running on port 3000`)
    });
}).catch((error) => {
    console.log(error)
})

