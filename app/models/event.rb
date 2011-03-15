class Event < ActiveRecord::Base
  
  has_many :attachments, :as => :attachable
  
  named_scope :forside_events, :conditions => ["active", true], :order => 'start_date DESC', :limit => 4
  
  named_scope :active_events, :conditions => ["active", true], :order => 'start_date DESC'
  
end
