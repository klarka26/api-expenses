class Expense < ApplicationRecord
  belongs_to :user
  belongs_to :supplier
  has_many :expense_items, dependent: :destroy

  accepts_nested_attributes_for :expense_items, allow_destroy: true

  validates :document_date, presence: true
  validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
