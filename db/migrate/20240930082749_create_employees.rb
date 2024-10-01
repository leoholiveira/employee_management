class CreateEmployees < ActiveRecord::Migration[7.2]
  def change
    create_table :employees, id: :uuid do |t|
      t.date :date_of_birth
      t.string :email
      t.string :first_name
      t.string :last_name
      t.text :address
      t.string :country
      t.text :bio
      t.float :rating

      t.timestamps
    end
  end
end
