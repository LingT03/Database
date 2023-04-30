// open database

// use blog;

// create collection
db.posts.insertMany([
  {
    author: "Sam Mai Tai",
    created_at: ISODate("2017-11-03T00:00:00Z"),
    content:
      "The pessimist sees difficulty in every opportunity. The optimist sees the opportunity in every difficulty.",
    likes: 12,
    tags: ["pessimist", "optimist"],
  },
  {
    author: "Sam Mai Tai",
    created_at: ISODate("2017-11-03T09:30:00Z"),
    content:
      "Age is a case of mind over matter. If you don't mind, it doesn't matter.",
    likes: 10,
    tags: ["age", "optimist"],
  },
  {
    author: "Sam Mai Tai",
    created_at: ISODate("2017-11-04T00:00:00Z"),
    content:
      "Failure will never overtake me if my determination to succeed is strong enough.",
    likes: 1,
    tags: ["optimist"],
  },
  {
    author: "Morbid Mojito",
    created_at: ISODate("2017-11-04T00:00:00Z"),
    content: "Only I can change my life. No one can do it for me.",
    tags: ["life"],
  },
  {
    author: "Morbid Mojito",
    created_at: ISODate("2017-11-07T00:00:00Z"),
    content:
      "Smile in the mirror. Do that every morning and you'll start to see a big difference in your life",
    likes: 1,
    tags: ["life", "optimist"],
  },
]);

// LIST ALL POSTS
db.posts.find();

// LIST ALL POSTS FROM 'SAM MAI TAI'
db.posts.find({ author: "sam mai tai" });

// LIST ONLY THE CONTENT OF ALL POSTS FROM 'SAM MAI TAI'
db.posts.find({ author: "sam mai tai" }, { content: 1 });

// LIST ALL POSTS IN 2017-11-04
db.posts.find({ created_at: isodate("2017-11-04t00:00:00z") });

// LIST ALL POSTS THAT HAD AT LEAST 5 LIKES
db.posts.find({ likes: { $gte: 5 } });

// LIST ALL POSTS FROM 'MORBID MOJITO' THAT HAD LESS THAN 3 LIKES
db.posts.find({ author: "morbid mojito", likes: { $lt: 3 } });

// LIST ALL POSTS FROM 'MORBID MOJITO' THAT HAD LESS THAN 3 LIKES OR DIDN'T HAVE ANY LIKES AT ALL
db.posts.find({ author: "morbid mojito", likes: { $lte: 3 } });

// LIST ALL POSTS THAT HAVE THE WORD 'YOU' IN ITS CONTENT
// HINT: USE THE $REGEX QUERY OPERATOR
db.posts.find({ content: { $regex: "you" } });

// LIST ALL POSTS OF AN AUTHOR WHOSE NAME ENDS WITH THE LETTER 'O' OR 'O'
// HINT: USE THE $REGEX QUERY OPERATOR
db.posts.find({ author: { $regex: "[oO]$" } });

// LIST ALL POSTS THAT HAVE THE TAG 'OPTIMIST'
// HINT: SEARCH THE DOCUMENTATION FOR HOW TO “QUERY AN ARRAY”
db.posts.find({ tags: "optimist" });

// LIST ALL POSTS THAT HAVE THE TAGS 'OPTIMIST' AND 'LIFE'
// HINT: YOU MIGHT WANT TO TRY THE $ALL QUERY OPERATOR OR JUST USE THE $AND QUERY OPERATOR
db.posts.find({ tags: { $ALL: ["optimist", "life"] } });

// LIST ALL POSTS THAT HAVE THE TAGS 'OPTIMIST' OR 'LIFE'
// HINT: USE THE $OR QUERY OPERATOR
db.posts.find({ tags: { $OR: ["optimist", "life"] } });

// LIST ALL POSTS THAT DO NOT HAVE THE TAG 'AGE'
// HINT: USE THE $NIN QUERY OPERATOR
db.posts.find({ tags: { $nin: ["age"] } });

// LIST ALL POSTS THAT ONLY HAVE ONE TAG
// HINT: USE THE $SIZE QUERY OPERATOR
db.posts.find({ tags: { $size: 1 } });
