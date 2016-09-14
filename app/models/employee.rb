class Employee < ApplicationRecord
  belongs_to :sector

  validates :name, presence: true, uniqueness: true
end
