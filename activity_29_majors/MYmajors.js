//use students

db.majors.insert({
  _id: "CS",
  description: "Computer Science",
});

db.majors.insert({
  _id: "BIOL",
  description: "Biology",
});

db.majors.insert({
  _id: "POSC",
  description: "Political Science",
});

db.students.insert({
  _id: 1,
  name: "Stephanie Schultz",
  majors: ["CS"],
});

db.students.insert({
  _id: 2,
  name: "Phillip Thomas",
  majors: ["BIOL"],
});

db.students.insert({
  _id: 3,
  name: "Christopher Smith",
  majors: ["BIOL"],
});

db.students.insert({
  _id: 4,
  name: "Megan Marshall",
  majors: ["POSC", "CS"],
});

db.students.insert({
  _id: 5,
  name: "Michael Morales Jr.",
  majors: ["POSC"],
});

// Stage 1: “unwind” majors
db.majors.aggregate([{ $unwind: "$majors" }]);

// Stage 2: Use $lookup to join the majors collection
db.students.aggregate([
  {
    $unwind: "$majors", // unwind to get one major per document
  },
  {
    $lookup: {
      from: "majors",
      localField: "majors",
      foreignField: "_id",
      as: "majors_detail",
    },
  },
]);

// Stage 3: "unwind" the majors_detail
db.students.aggregate([
  {
    $unwind: "$majors", // unwind to get one major per document
  },
  {
    $lookup: {
      from: "majors",
      localField: "majors",
      foreignField: "_id",
      as: "majors_detail",
    },
  },
  {
    $unwind: "$majors_detail",
  },
]);

// Stage 4: group and push
db.students.aggregate([
  {
    $unwind: "$majors", // unwind to get one major per document
  },
  {
    $lookup: {
      from: "majors",
      localField: "majors",
      foreignField: "_id",
      as: "majors_detail",
    },
  },
  {
    $unwind: "$majors_detail", // unwind to get one major per document
  },
  {
    $group: {
      _id: "$_id",
      name: { $first: "$name" },
      majors: { $push: "$majors_detail" }, // pused major_detail into major associated with a student
    },
  },

  {
    $project: {
      _id: 1,
      name: 1,
      majors: 1,
    },
  },

  {
    $sort: {
      _id: 1,
    },
  },
]);
