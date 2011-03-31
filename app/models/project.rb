class Project < ActiveRecord::Base
  
  has_many :attachments, :as => :attachable
  
  named_scope :forside_projects, :conditions => ["active", true], :order => 'start_date DESC', :limit => 4
  
  named_scope :active_projects, :conditions => ["active", true], :order => 'start_date DESC'
  
end
