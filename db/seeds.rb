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
user1.email = 'fuentes.vincent96@gmail.com'
user1.password = 'john12345'
user1.save!

user2 = User.new
user2.username = 'DwayneD'
user2.name = 'Dwayne Johnson'
user2.email = 'vzangel247@gmail.com'
user2.password = 'therock12345'
user2.save!