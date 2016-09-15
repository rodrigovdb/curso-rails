class ContactType < ApplicationRecord
  has_many :contacts

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
