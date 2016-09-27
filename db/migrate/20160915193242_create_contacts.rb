class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|
      t.references :employee, foreign_key: true
      t.references :contact_type, foreign_key: true
      t.string :phone_number

      t.timestamps
    end
  end
end
