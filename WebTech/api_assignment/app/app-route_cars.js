import express from "express";
import Cars from "../js/cars.js";
const showroom = express.Router();
// ----------------------------------------------------
// Cars API
// ----------------------------------------------------
let cars = [];

cars.push(new Cars(1, "audi", "A101", 100));
cars.push(new Cars(2, "bmw", "B201", 200));
cars.push(new Cars(3, "ford", "C301", 50));

// Read
showroom.get("/cars", (req, res) => {
  res.setHeader("Content-Type", "application/json");
  res.send(cars);
});

showroom.get("/cars/:carid", (req, res) => {
  res.setHeader("Content-Type", "application/json");
  // res.send(cars[]);f
  const car = cars.find((c) => c.carid == req.params.carid);
  if (car) {
    res.send(car);
  } else {
    res.status(404).send("Car not found");
  }
});

showroom.delete("/cars/:carid", (req, resp) => {
  // console.log('delete called')
  resp.setHeader("Content-Type", "application/json");
  const cid = req.params.carid;
  cars = cars.filter(function (v, i, a) {
    return a[i].carid != cid;
  });
  console.log(cars);
  resp.send(cars);
});

// Create
showroom.post("/cars/add", (req, resp) => {
  resp.setHeader("Content-Type", "application/json");
  let carid = req.body.carid;
  let carName = req.body.carName;
  let carModel = req.body.carModel;
  let carPrice = req.body.carPrice;
  cars.push(new Cars(carid, carName, carModel, carPrice));
  resp.send("Car added");
});

// Delete
// showroom.get("/cars/delete/:carid", (req, res) => {
//   res.setHeader("Content-Type", "application/json");
//   let temp = [];
//   for (let i in cars) {
//     if (req.params.carid != cars[i].carid) {
//       temp.push(cars[i]);
//     }
//   }
//   cars = temp;
//   res.redirect("/cars");
// });

// Update
showroom.put("/cars/:carid/:carPrice", (req, resp) => {
  resp.setHeader("Content-Type", "application/json");
  const cid = req.params.carid;
  console.log(cid);
  const car = cars.find((c) => c.carid == cid);
  if (car) {
    car.carPrice = req.params.carPrice;
    resp.send(JSON.stringify(car) + " updated with new price");
  } else {
    resp.status(404).send(cid + " No product found");
  }
});

export default showroom;
