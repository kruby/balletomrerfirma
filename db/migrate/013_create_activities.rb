class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.boolean :active
      t.string :title
      t.text :description
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end

  def self.down
    drop_table :activities
  end
end
