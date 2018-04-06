require 'rails_helper'

RSpec.describe Expense, type: :model do 
 context "The Expense exists" do
  it "should belong to a user" do
  	time = Time.now.freeze
  	user = User.create!(email: Faker::Internet.email, password: Faker::Internet.password(6))
  	expense = Expense.new(amount: 30000, concept: "Uber", date: time, users: user)
  	expect(expense.valid?).to eq(true)
  end
 end	
end