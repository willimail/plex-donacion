# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
willy = User.create(first_name: 'Willy', last_name: 'GT', email: 'willimail@gmail.com', password: 'mAm1plex', password_confirmation: 'mAm1plex', role: 'admin')