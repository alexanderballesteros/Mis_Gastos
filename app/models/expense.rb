class Expense < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :transaction_type

  validates :user_id, presence: true
  validates :category, presence: true
  validates :transaction_type, presence: true
  validates :amount, numericality: { greater_than: 0 }
  validates :concept, presence: true
  before_create :date_cant_be_nil

  scope :daily_expenses, -> {where("date >= ?", DateTime.now.beginning_of_day)}
  scope :yesterday_expenses, -> {where("date between ? and ?", 1.day.ago.beginning_of_day, 1.day.ago.end_of_day)}
  scope :this_month, -> {where("extract(month from date) = ?", Time.now.month)}
  scope :last_month, -> {where("date >= ?", 1.months.ago)}
  scope :last_six_months, -> {where("date >= ?", 6.months.ago)}
  scope :group_category_this_month, -> {this_month.group_by { |expense| expense.category.name}}
  scope :group_category_last_six_months, -> {last_six_months.group_by { |expense| expense.category.name}}
  scope :group_category_last_six_months_per_day, -> {group_category_last_six_months.group_by { |expense| expense.category.name}}


  def date_cant_be_nil
    if self.date.nil?
      self.date = Time.now
    end
  end


end