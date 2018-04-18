require 'rails_helper'

RSpec.describe Expense, type: :model do
  context "The expense exists" do

    it "should belong to a user" do
      time = Time.now.freeze
      category = FactoryBot.create(:category)
      transaction_type = FactoryBot.create(:transaction_type)
      user_1 = User.create!(email: Faker::Internet.email, password: Faker::Internet.password(6))
      expense_1 = Expense.new(amount: 30000, concept: "Uber", date: time, user: user_1, category: category, transaction_type: transaction_type)

      expect(expense_1.valid?).to eq(true)
      expect(expense_1.save!).to eq(true)
      expect(Expense.count).to eq(1)
      expect(user_1.expenses).to eq([expense_1])
      expect(expense_1.user).to eq(user_1)
    end

    context "amount related" do
      before do
        time = Time.now.freeze
        category = FactoryBot.create(:category)
        transaction_type = FactoryBot.create(:transaction_type)
        user_1 = User.create!(email: Faker::Internet.email, password: Faker::Internet.password(6))
        @expense_1 = Expense.new(concept: "Uber", date: time, user: user_1, category: category, transaction_type: transaction_type)
      end

      context "the amount is negative" do
        it "should not save the expense" do
          @expense_1.amount = -200
          expect(@expense_1.valid?).to be_falsey
          expect(@expense_1.save).to be_falsey
          expect(@expense_1.errors.messages).not_to be_empty
        end
      end

      context "the amount is positive" do
        it "should save the expense" do
          @expense_1.amount = 20000
          @expense_1.valid?
          puts @expense_1.errors.messages.inspect
          expect(@expense_1.valid?).to be_truthy
          expect(@expense_1.save).to be_truthy
          expect(@expense_1.errors.messages).to be_empty
        end
      end
    end
    context "concept related" do
      before do
        time = Time.now.freeze
        category = FactoryBot.create(:category)
        transaction_type = FactoryBot.create(:transaction_type)
        user_1 = User.create!(email: Faker::Internet.email, password: Faker::Internet.password(6))
        @expense_1 = Expense.new(amount: 20000, date: time, user: user_1, category: category, transaction_type: transaction_type)
      end

      context "the concept is empty" do
        it "should not save the expense and show an error" do
          expect(@expense_1.valid?).to be_falsey
          expect(@expense_1.save).to be_falsey
          expect(@expense_1.errors.messages).not_to be_empty
        end
      end

      context "the concept is not empty" do
        it "should save the expense" do
          @expense_1.concept = "Uber"
          expect(@expense_1.concept).to eq("Uber")
          expect(@expense_1.valid?).to be_truthy
          expect(@expense_1.save).to be_truthy
          expect(@expense_1.errors.messages).to be_empty
        end
      end
    end
    context "date related" do
      before do
        category = FactoryBot.create(:category)
        transaction_type = FactoryBot.create(:transaction_type)
        user_1 = User.create!(email: Faker::Internet.email, password: Faker::Internet.password(6))
        @expense_1 = Expense.new(amount: 20000, concept: "Uber", user: user_1,  category: category, transaction_type: transaction_type)
      end

      context "the date is empty" do
        it "should save the expense and set the current date on the date field" do
          expect(@expense_1.save).to be_truthy
          expect(@expense_1.date).not_to be_nil
          expect(@expense_1.errors.messages).to be_empty
        end
      end

      context "the date is not empty" do
        it "should save the expense" do
          time = Time.now.freeze
          @expense_1.date = time
          expect(@expense_1.valid?).to be_truthy
          expect(@expense_1.save).to be_truthy
          expect(@expense_1.date).to eq(time)
          expect(@expense_1.errors.messages).to be_empty
        end
      end
    end
    context "category related" do
     before do
       time = Time.now.freeze
        transaction_type = FactoryBot.create(:transaction_type)
       user = User.create(email: Faker::Internet.email, password: Faker::Internet.password(6))
       @category = FactoryBot.create(:category)
       @expense = Expense.new(amount: 30000, concept: "Uber", user: user, date: time, transaction_type: transaction_type)
     end
     context "the category appear" do
       it "should save the expenses" do
         @expense.category = @category
         expect(@expense.valid?).to be_truthy
         expect(@expense.save).to be_truthy
         expect(@expense.errors.messages).to be_empty
       end
     end
     context "category not there" do
       it "should not save the expense" do
         expect(@expense.valid?).to be_falsey
         expect(@expense.save).to be_falsey
         expect(@expense.errors).not_to be_empty
       end
     end
  end
  context "Transaction Type related" do
     before do
       time = Time.now.freeze
       @transaction_type = FactoryBot.create(:transaction_type)
       user = User.create(email: Faker::Internet.email, password: Faker::Internet.password(6))
       category = FactoryBot.create(:category)
       @expense = Expense.new(amount: 30000, concept: "Uber", user: user, date: time, category: category )
     end
     context "the Transaction Type appear" do
       it "should save the expenses" do
         @expense.transaction_type = @transaction_type
         expect(@expense.valid?).to be_truthy
         expect(@expense.save).to be_truthy
         expect(@expense.errors.messages).to be_empty
       end
     end
     context "Transaction Type not there" do
       it "should not save the expense" do
         expect(@expense.valid?).to be_falsey
         expect(@expense.save).to be_falsey
         expect(@expense.errors).not_to be_empty
       end
     end
  end
end
end
