class CreateContents < ActiveRecord::Migration
  def self.up
    create_table :contents do |t|
      t.string   :name
      t.integer  :resource_id
      t.string   :resource_type
      t.integer  :parent_id
      t.string   :navlabel
      t.boolean  :active
      t.integer  :position,   :default => 1
      t.string   :controller_name
      t.string   :category, :default => "Admin"
      t.string   :controller_redirect
      t.string   :action_redirect
      t.boolean  :redirect

      t.timestamps
    end
  end

  def self.down
    drop_table :contents
  end
end
