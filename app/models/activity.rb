class Activity < ActiveRecord::Base
  
  named_scope :forside_activities, :conditions => ["active", true], :order => 'created_at DESC', :limit => 4
  
end
