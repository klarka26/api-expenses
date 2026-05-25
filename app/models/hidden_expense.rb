class HiddenExpense < ApplicationRecord
  belongs_to :user
  belongs_to :expense

  validates :expense_id, uniqueness: { scope: :user_id }
end