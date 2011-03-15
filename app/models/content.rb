class Content < ActiveRecord::Base
   
  acts_as_tree :order => "position"
  
  named_scope :admin_pages, :conditions => ["parent_id IS NULL and active and category = 'admin'", true], :order => 'position'
  named_scope :editor_pages, :conditions => ["parent_id IS NULL and active and category = 'editor'", true], :order => 'position'
  named_scope :user_pages, :conditions => ["parent_id IS NULL and active and category = 'user'", true], :order => 'position'
  named_scope :public_pages, :conditions => ["parent_id IS NULL and active and category = 'public' ", true], :order => 'position'
    
  named_scope :main_menu, :conditions => ["parent_id IS NULL and active and category = 'public' ", true], :order => 'position'
  
  named_scope :pages, :conditions => {:controller_name => 'pages'}, :order => 'position'
  
  named_scope :active, :conditions => {:active => true }, :order => 'position'
  
  belongs_to :resource, :polymorphic => true
  
  
  named_scope :pages, :conditions => {:resource_type => 'Page'}, :order => 'position'
  named_scope :menus, :conditions => {:resource_type => 'Menu'}, :order => 'position'
  named_scope :active, :conditions => {:active => true }, :order => 'position'
  
end
