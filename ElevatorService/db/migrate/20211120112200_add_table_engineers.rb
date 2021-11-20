class AddTableEngineers < ActiveRecord::Migration[6.0]
  def change
    create_table :engineers do |t|
      t.column :no, :string, :null => false
      t.column :name, :string, :null => false
      t.column :description, :string, :null => false
      t.column :created_at, :datetime, :null => false
      t.column :updated_at, :datetime, :null => false
    end
  end
end
