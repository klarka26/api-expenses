class ExpenseItem < ApplicationRecord
  belongs_to :expense

  validates :description, presence: true
  validates :quantity, numericality: { greater_than: 0 }
  validates :unit_price, numericality: true
end
