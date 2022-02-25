import express from "express";
import Persons from "../js/Persons.js";
const society = express.Router();
// ----------------------------------------------------
// Person API
// ----------------------------------------------------
let persons = [];

persons.push(new Persons(1, "fname1", "lname1", 20, "M"));
persons.push(new Persons(2, "fname2", "lname2", 30, "M"));
persons.push(new Persons(3, "fname3", "lname3", 20, "F"));

// Read
society.get("/persons", (req, res) => {
  res.setHeader("Content-Type", "application/json");
  res.send(persons);
});

society.get("/persons/:pid", (req, res) => {
  res.setHeader("Content-Type", "application/json");
  // res.send(books[]);f
  const person = persons.find((p) => p.pid == req.params.pid);
  if (person) {
    res.send(person);
  } else {
    res.status(404).send("Person not found");
  }
});

society.delete("/persons/:pid", (req, resp) => {
  // console.log('delete called')
  resp.setHeader("Content-Type", "application/json");
  const delete_pid = req.params.pid;
  persons = persons.filter(function (v, i, a) {
    return a[i].pid != delete_pid;
  });
  console.log(persons);
  resp.send(persons);
});

// Create
society.post("/persons/add", (req, resp) => {
  resp.setHeader("Content-Type", "application/json");
  let pid = req.body.pid;
  let fname = req.body.firstName;
  let lname = req.body.lastName;
  let age = req.body.age;
  let gen = req.body.gender;
  persons.push(new Persons(pid, fname, lname, age, gen));
  resp.send("Person added");
});
// Delete
// society.get("/persons/delete/:pid", (req, res) => {
//   res.setHeader("Content-Type", "application/json");
//   let temp = [];
//   for (let i in persons) {
//     if (req.params.pid != persons[i].pid) {
//       temp.push(persons[i]);
//     }
//   }
//   persons = temp;
//   res.redirect("/persons");
// });

// Update
society.put("/persons/:pid/:age", (req, resp) => {
  resp.setHeader("Content-Type", "application/json");

  const per_id = req.params.pid;
  console.log(per_id);
  const person = persons.find((p) => p.pid == per_id);

  if (person) {
    person.age = req.params.age;

    resp.send(JSON.stringify(person) + " updated with new age");
  } else {
    resp.status(404).send(per_id + " No person found");
  }
});
export default society;
