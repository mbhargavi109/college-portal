class AddFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :role, :string, null: false
    add_column :users, :semester, :integer
    add_column :users, :roll_number, :string

    add_reference :users, :department, null: false, foreign_key: true
    add_reference :users, :subject, null: false, foreign_key: true
  end
end
