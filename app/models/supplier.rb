class Supplier < ApplicationRecord
  has_many :expenses

  validates :name, presence: true
  validates :ico, length: { maximum: 30 }

  def self.find_or_create(data)
    # hladanie podla ico alebo name
    if data[:ico].present?
      matching_suppliers = where(ico: data[:ico])
    else
      matching_suppliers = where(name: data[:name])
    end

    return create(data) if matching_suppliers.empty?

    # zistenie ci su ostatne udaje zhodne
    matching_suppliers.each do |supplier|
      conflict = false

      [:name, :dic, :ic_dph, :address].each do |field|
        old_val = supplier[field]
        new_val = data[field]

        if old_val.present? && new_val.present? && old_val != new_val
          conflict = true
          break
        end
      end

      # ak sa udaje zhoduju alebo su prazdene, tak sa aktualizuje
      unless conflict
        supplier.name    = data[:name]    if supplier.name.blank? && data[:name].present?
        supplier.dic     = data[:dic]     if supplier.dic.blank? && data[:dic].present?
        supplier.ic_dph  = data[:ic_dph]  if supplier.ic_dph.blank? && data[:ic_dph].present?
        supplier.address = data[:address] if supplier.address.blank? && data[:address].present?

        supplier.save if supplier.changed?
        return supplier
      end
    end

    create(data)
  end
end
