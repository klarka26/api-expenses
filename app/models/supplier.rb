class Supplier < ApplicationRecord
  has_many :expenses

  validates :name, presence: true, length: { maximum: 30 }
  validates :ico, presence: true, length: { maximum: 30 }


  def self.find_or_create(data)
    find_or_create_by!(ico: data[:ico]) do |s|
      s.name    = data[:name]
      s.dic     = data[:dic]
      s.ic_dph  = data[:ic_dph]
      s.address = data[:address]
    end
  end
end
