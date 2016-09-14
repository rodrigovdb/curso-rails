class CreateEmployees < ActiveRecord::Migration[5.0]
  def change
    create_table :employees do |t|
      t.references :sector, foreign_key: true
      t.string :name
      t.string :sex
      t.date :birth_date

      t.timestamps
    end
  end
end
