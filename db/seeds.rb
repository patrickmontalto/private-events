# Create users
User.create!(first_name: "Patrick",
             last_name:  "Montalto",
             email: "pmontalto@yahoo.com")
User.create!(first_name: "Jesse",
             last_name:  "Montalto",
             email: "jmontalto@yahoo.com")
User.create!(first_name: "Melo",
             last_name: "Montalto",
             email: "melo@gmail.com")
User.create!(first_name: "Barkley",
             email: "barkley@aol.com")

# Create events for both past and future
Event.create!(title: "Birthday Party",
              location: "Long Island",
              datetime: Time.now,
              creator_id: 1)

Event.create!(title: "Turkey Day",
              location: "Our House",
              datetime: "2015-11-26 18:00:00",
              creator_id: 3)

