# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

user1 = User.new
user1.username = 'JohnC'
user1.name = 'John Cena'
user1.email = 'vzangel247@gmail.com'
user1.password = 'john12345'
user1.save!

user2 = User.new
user2.username = 'DwayneD'
user2.name = 'Dwayne Johnson'
user2.email = 'johntest@gmail.com'
user2.password = 'therock12345'
user2.save!

#post create
post1 = user1.posts.create!(
  title: "Rails Seed Tutorial: Creating Posts and Comments",
  body: "In this tutorial, we'll learn how to create posts and comments in a Rails application using seeds."
)

post2 = user2.posts.create!(
  title: "Exploring the Power of Faker for Realistic Data",
  body: "The Faker gem can be a valuable tool for generating realistic test data in your Rails app. Let's dive into its features!"
)

#post comments
post1.comments.create!(
  message: "This is a manually created comment for post 1.",
  user: user1
)

post1.comments.create!(
  message: "Another comment for post 1, also manually created.",
  user: user2
)

#new implementation of the votes 
# post1.comments.create!(
#   message: "Another comment for post 1, also manually created.",
#   user: user2,
#   votes: {
#     upvotes: [], 
#     downvotes: []
#   }
# )

#commens for the comments
# comment1 = post1.comments.first
# comment2 = post2.comments.first

# comment1.comments.create!(
#   message: "This is a nested comment for the first comment on post 1.",
#   user: user1,
#   votes: 3
# )

# comment2.comments.create!(
#   message: "A nested comment for the first comment on post 2.",
#   user: user2,
#   votes: 4
# )

# puts "Seeded #{Post.count} posts and #{Comment.count} comments."
