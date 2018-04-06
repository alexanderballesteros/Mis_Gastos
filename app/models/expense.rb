class Expense < ApplicationRecord
	validates :users_id, presence: true
	belongs_to :users
end