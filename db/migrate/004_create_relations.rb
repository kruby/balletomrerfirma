class CreateRelations < ActiveRecord::Migration
  def self.up
    create_table :relations do |t|
      t.string    :company
      t.string    :address
      t.string    :postno
      t.string    :city
      t.string    :vat_no
      t.string    :contact
      t.text      :log
      t.string    :category
      t.string    :responsible
      t.text      :contact_info
      t.datetime  :next_action
      t.integer   :search_lock
      t.integer   :lock_version, :default => 0, :null => false
      t.integer   :user_id
      t.string    :type
      t.string    :homepage
      t.string    :email
      t.text      :order_info

      t.timestamps
    end
  end

  def self.down
    drop_table :relations
  end
end
