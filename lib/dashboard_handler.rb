#This lib will handle the dashboard information from scopes for graphics
#visualization to total graphics
class DashboardHandler

 def initialize(expenses)
  @expenses = expenses
 end
 
 def today_expenses
   @expenses.daily_expenses.pluck(:amount).sum
 end

 def yesterday_expenses
   @expenses.yesterday_expenses.pluck(:amount).sum
 end

 def this_month_expenses
   @expenses.this_month.pluck(:amount).sum
 end

 def last_month_expenses
   @expenses.last_month.pluck(:amount).sum   
 end

 def by_transaction_type_by_month_last_six_month_expenses
   
 end

 def by_day_by_transaction_type_this_month_expenses
   
 end

 def by_category_this_month_expenses
   
 end

 def accomulated_this_month_vs_last_month_expenses
   
 end



end