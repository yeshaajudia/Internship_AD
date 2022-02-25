import express from "express";
import Books from "../js/books.js";
const library = express.Router();
// ----------------------------------------------------
// Book API
// ----------------------------------------------------
let books = [];

books.push(new Books(1, "name1", "author1", 100));
books.push(new Books(2, "name2", "author2", 100));
books.push(new Books(3, "name3", "author3", 100));

// Read
library.get("/books", (req, res) => {
  res.setHeader("Content-Type", "application/json");
  res.send(books);
});

library.get("/books/:bookid", (req, res) => {
  res.setHeader("Content-Type", "application/json");
  // res.send(books[]);f
  const book = books.find((b) => b.bookid == req.params.bookid);
  if (book) {
    res.send(book);
  } else {
    res.status(404).send("Book not found");
  }
});

library.delete("/books/:bookid", (req, resp) => {
  // console.log('delete called')
  resp.setHeader("Content-Type", "application/json");
  const delete_bookid = req.params.bookid;
  books = books.filter(function (v, i, a) {
    return a[i].bookid != delete_bookid;
  });
  console.log(books);
  resp.send(books);
});

// server.delete('/books/:bookid', (req, resp) => {
//     resp.setHeader('Content-Type', 'application/json');
//     const delete_bookid = req.params.bookid;
//     books.forEach(book => {
//         if (book.bookid === req.params.bookid) {
//             books.pop();
//         }
//     });
//     resp.redirect('/books')
// })

// Create
library.post("/books/add", (req, resp) => {
  resp.setHeader("Content-Type", "application/json");
  let bookid = req.body.bookid;
  let bookname = req.body.bookname;
  let authorname = req.body.authorname;
  let unitprice = req.body.unitprice;
  books.push(new Books(bookid, bookname, authorname, unitprice));
  resp.send("Book added");
});
// Delete
// server.get("/books/delete/:bookid", (req,res)=>{
//     res.setHeader('Content-Type','application/json');
//     let temp = [];
//     for  (let i in books) {
//         if (req.params.bookid != books[i].bookid){
//             temp.push(books[i]);
//         }
//     }
//     books = temp;
//     res.redirect('/books');
// })

// Update
library.put("/books/:bookid/:unitprice", (req, resp) => {
  resp.setHeader("Content-Type", "application/json");
  const bid = req.params.bookid;
  // console.log(bid)
  const book = books.find((b) => b.bookid == bid);
  if (book) {
    book.unitprice = req.params.unitprice;

    resp.send(JSON.stringify(book) + " updated with new price");
  } else {
    resp.status(404).send(bid + " No product found");
  }
});

export default library;
