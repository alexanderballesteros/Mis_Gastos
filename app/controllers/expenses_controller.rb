class ExpensesController < ApplicationController
  def index
  	transaction_type = params[:transaction_type]
  	category = params[:category]
    puts "\n" * 5
    puts params.inspect
    if transaction_type
      @expenses = Expense.joins(:transaction_type, :category).where("transaction_types.name = ?", transaction_type.capitalize).limit(10)
    else
      @expenses = Expense.last(10)
    end
  	@transaction_type = TransactionType.all
    @categories = Category.all 
  	respond_to do |format|
  		format.html {render :index}
  		format.json {render json: @expenses, status: :ok}
      format.js { render partial: "expenses_list", locals: { cositas: @expenses}}
  	end
  end
end
