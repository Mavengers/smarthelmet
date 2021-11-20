class AddTableCases < ActiveRecord::Migration[6.0]
  def change
    create_table :cases do |t|
      t.references :engineer, :null => false
      t.column :case_name, :string, :null => false, :unique => true
      t.column :elevator_tag, :string, :null => false
      t.column :description, :string, :null => false
      t.column :created_at, :datetime, :null => false
      t.column :updated_at, :datetime, :null => false
    end
  end
end
