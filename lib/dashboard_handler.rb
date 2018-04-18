#This lib will handle the dashboard information from scopes for graphics
#visualization to total graphics
class DashboardHandler

 def initialize(expenses)
  @expenses = expenses
 end
 
 def today_expenses
   @expenses.daily_expenses.pluck(:amount).sum
 end

end