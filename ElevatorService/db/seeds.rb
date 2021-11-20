# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

engineer = Engineer.create(id: 1, no: 'engineer001', name: 'bigbro', description: 'The smart & handsome guy')
# engineer.save!
puts engineer.to_json
