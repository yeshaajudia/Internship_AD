import express from 'express';
import path from 'path';

import library from './app/app-route_books.js';
import society from './app/app-route_persons.js';
import showroom from './app/app-route_cars.js';

// import Books from './js/books.js';
// import Cars from './js/cars.js';
// import Persons from './js/Persons.js';

const server = express();
const port = 3000;
server.use(express.urlencoded({ extended: true }));
server.use(express.json());
const __dirname = path.resolve(path.dirname(""));

server.get('/', (req, resp) => {
    resp.setHeader('Content-Type', "text/html");
    // resp.send({message:"Welcome to Express Server"});
    resp.sendFile(__dirname + "/index.html");
});

// Create a route such as http://localhost:3000/library
server.use('/library',library);
// Create a route such as http://localhost:3000/showroom
server.use('/showroom',showroom);
// Create a route such as http://localhost:3000/society
server.use('/society',society);

// server.get('/persons', (req, resp) => {
//     resp.setHeader('Content-Type', 'text/html');
//     resp.sendFile(__dirname + "/persons.html");
// })

// server.get('/cars', (req, resp) => {
//     resp.setHeader('Content-Type', 'text/html');
//     resp.sendFile(__dirname + "/cars.html");
// })

// server.get('/books', (req, resp) => {
//     resp.setHeader('Content-Type', 'text/html');
//     resp.sendFile(__dirname + "/books.html");
// })

server.listen(port, () => { console.log("http://localhost:3000"); })