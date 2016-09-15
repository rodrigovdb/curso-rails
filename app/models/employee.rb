class Employee < ApplicationRecord
  belongs_to  :sector
  has_many    :contacts

  validates :name, presence: true, uniqueness: true
end
