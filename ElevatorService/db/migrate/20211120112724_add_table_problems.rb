class AddTableProblems < ActiveRecord::Migration[6.0]
  def change
    create_table :problems do |t|
      t.references :case, :null => false
      t.column :label, :string, :null => false
      t.column :photo_url, :string, :null => false
      t.column :description, :string, :null => false, :default => ''
      t.column :created_at, :datetime, :null => false
      t.column :updated_at, :datetime, :null => false
    end
  end
end
