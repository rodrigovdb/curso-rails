class Employee < ApplicationRecord
  belongs_to  :sector
  has_many    :contacts

  validates :name,        length: { in: 3..255 }
  validates :birth_date,  presence: true

  scope :partial_name, -> (name) { where('name like ?', "%#{name}%") }
end
