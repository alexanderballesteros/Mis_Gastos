class Expense < ApplicationRecord
	validates :users_id, presence: true
end