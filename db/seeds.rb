# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create!(first_name: '1', last_name: '1', email: '1@example.org', time_zone: 'Europe/Berlin')
user.update(token: 'token')

recipient_user2 = User.create!(first_name: '2', last_name: '2', email: '2@example.org', time_zone: 'America/New_York')
recipient_user2.update(token: 'recipient_token2')

recipient_user3 = User.create!(first_name: '3', last_name: '3', email: '3@example.org', time_zone: 'America/Los_Angeles')
recipient_user3.update(token: 'recipient_token3')

Message.create!(content: 'recipient_user2', sender: user, user_ids: [recipient_user2.id])
Message.create!(content: 'recipient_user3', sender: user, user_ids: [recipient_user3.id])
Message.create!(content: 'recipient_user2 recipient_user3', sender: user, user_ids: [recipient_user2.id, recipient_user3.id])
