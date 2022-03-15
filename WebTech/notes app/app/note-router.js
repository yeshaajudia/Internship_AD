import express from "express";
import Notes from "../js/notes.js";

const router = express.Router();
let notes = [];
let id = 1;
notes.push(new Notes(id++, "First", "This is first note"));
notes.push(new Notes(id++, "Second", "Add your own notes here"));

router.get("/", (req, res) => {
  res.render('index',{notes})
});

router.get('/add', (req,res) => {
  res.render('new');
})

// router.get("/:noteid", (req, res) => {
//   res.setHeader("Content-Type", "application/json");
//   const note = notes.find((n) => n.noteid == req.params.noteid);
//   if (note) {
//     res.send(note);
//   } else {
//     res.status(404).send("Note not found");
//   }
// });

router.get('/update/:noteid', (req,res)=> {
  const note = notes.find((n) => n.noteid == req.params.noteid);
  res.render('update',{note})
});


router.post("/update/:noteid", (req, res) => {
    notes.forEach(note=>{
        if(note.noteid==req.params.noteid){
            note.title = req.body.title;
            note.content=req.body.content;
            res.render('updated', {"message":"updated successfully"})
        }
    })
    res.render('updated',{"message":"Failed to updated"});
});



router.post("/add", (req, res) => {
  const note = req.body;
  notes.push(new Notes(id++, note.title, note.content));
  res.redirect('/notes');
});

router.get("/delete/:noteid", (req, res) => {
  const noteid = req.params.noteid;
  notes = notes.filter(function (v, i, a) {
    return a[i].noteid != noteid;
  });
  res.redirect('/notes');
});

export default router;
