class CreateLists < ActiveRecord::Migration
  def self.up
    create_table :lists do |t|
      t.boolean :active, :default => nil
      t.string :name
      t.text :description
      t.string :model_name

      t.timestamps
    end
  end

  def self.down
    drop_table :lists
  end
end
