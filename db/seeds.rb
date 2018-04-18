# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
new_category = Category.create!([{name: 'Restaurant'},{name: 'Grocery'},{name: 'Car'},{name: 'Service'},{name: 'Home'},{name: 'Education'},{name: 'Fun'}])
new_transaction = TransactionType.create!([{name: 'Purchase'},{name: 'Withdrawals'}, {name: 'Transfer'}, {name: 'Payment'}])
100.times do
 User.create(email: Faker::Internet.email, password: Faker::Internet.password)
end
100.times do
 Expense.create(user: User.all.sample, amount: Faker::Number.between(1000,600000), concept: Faker::Beer.name, date: Faker::Date.between(6.months.ago, Date.today), category_id: Category.all.sample.id, transaction_type_id: TransactionType.all.sample.id)
end