import express from 'express';
import path from 'path';
import router from './app/note-router.js';

const message = 'App running on http://localhost:1337/';
const port = 1337;
const __dirname=path.resolve(path.dirname(''));
const server = express();

server.set('view engine', 'ejs');
server.set('views', path.join(__dirname,'views'));
server.use(express.urlencoded({extended:true}));
server.use(express.json());
server.use('/notes',router);


server.get('/',(req,res)=>{
   res.redirect('/notes');
});


server.listen(port,()=>{
    console.log(message);
});