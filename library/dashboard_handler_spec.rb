require 'rails_helper'
require './lib/dashboard_handler'

RSpec.describe DashboardHandler do
  before do
  @user = FactoryBot.create(:user)	
  time = Time.now.freeze
   new_expense_1 = FactoryBot.create(:expense, user: @user, date: time)
   new_expense_2 = FactoryBot.create(:expense, user: @user, concept: "This is something", date: time)
   new_expense_3 = FactoryBot.create(:expense, user: @user, amount: 4000, date: time)
   new_expense_4 = FactoryBot.create(:expense, user: @user, amount: 4000, date: 2.days.ago)
   new_expense_5 = FactoryBot.create(:expense, user: @user, amount: 4000, date: 2.days.ago)
  end  
  describe "Expense Today"  do
   it"should calculate today expenses" do
   	@user.expenses.daily_expenses.count
     new_handler = DashboardHandler.new(@user.expenses)
     expect(new_handler.today_expenses).to eq (54000) 
     
     end
   end 
end