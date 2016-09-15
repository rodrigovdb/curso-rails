class Contact < ApplicationRecord
  belongs_to :employee
  belongs_to :contact_type

  validates :phone_number, format: {
              with: %r{\A\(\d{2}\)\d{4,5}-\d{4}\z},
              message: "Invalid phone. Use (41)3333-3333 or (41)33333-3333"
            }
end
