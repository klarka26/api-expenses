class User < ApplicationRecord

  NAME_REGEX = /\A[a-zA-ZáäčďéíľĺňóôŕšťúýžÁÄČĎÉÍĽĹŇÓÔŔŠŤÚÝŽ\s\-]+\z/

  devise :database_authenticatable,
         :registerable,
         :validatable,
         :jwt_authenticatable,
          jwt_revocation_strategy: JwtDenylist

  has_many :expenses
  has_many :hidden_expenses, dependent: :destroy

  enum :role, { user: "user", admin: "admin" }, default: "user"

  def accessible_expenses
    if admin?
      Expense.where(hidden_from_admin: false)
    else
      expenses
    end
  end

  validates :first_name, presence: true, length: { maximum: 30 }, format: { with: NAME_REGEX }
  validates :last_name, presence: true, length: { maximum: 30 }, format: { with: NAME_REGEX }
end
