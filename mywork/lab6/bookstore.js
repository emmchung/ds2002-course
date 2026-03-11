
use bookstor

insert first author
db.authors.insertOne({
  name: "Jane Austen",
  nationality: "British",
  bio: {
    short: "English novelist known for novels about the British landed gentry.",
    long: "Jane Austen was an English novelist whose works critique and comment upon the British landed gentry at the end of the 18th century."
  }
})

db.authors.updateOne(
  { name: "Jane Austen" },
  { $set: { birthday: "1775-12-16" } }
)

db.authors.insertMany([
{
  name: "Charles Dickens",
  nationality: "British",
  bio: { short: "Victorian English writer.", long: "Author of Oliver Twist and Great Expectations." },
  birthday: "1812-02-07"
},
{
  name: "Franz Kafka",
  nationality: "Czech",
  bio: { short: "German-speaking writer.", long: "Author of The Metamorphosis." },
  birthday: "1883-07-03"
},
{
  name: "Leo Tolstoy",
  nationality: "Russian",
  bio: { short: "Russian novelist.", long: "Author of War and Peace and Anna Karenina." },
  birthday: "1828-09-09"
},
{
  name: "Gabriel Garcia Marquez",
  nationality: "Colombian",
  bio: { short: "Magical realism author.", long: "Author of One Hundred Years of Solitude." },
  birthday: "1927-03-06"
}
])

db.authors.countDocuments()

db.authors.find({ nationality: "British" }).sort({ name: 1 })
