class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.boolean  :active, :default => 1
      t.string :title
      t.text :description
      t.date :start_date
      t.date :end_date
      t.integer :position
      t.integer :rating

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
