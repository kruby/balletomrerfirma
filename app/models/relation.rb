class Relation < ActiveRecord::Base
  
  # def self.search(search, page)
  #   paginate  :per_page => 10, :page => page,
  #             #:conditions => "active = 1 and name like '%#{search}%'", #De 2 nedenfor sammenskrevet til 1 linie og med AND
  #             #:conditions => ['active = ?', 1],
  #             :conditions => ['company like ?', "%#{search}%"],
  #             #:conditions => ['city like ?', "%#{search}%"],
  #             :order => 'company'
  # end
  
  named_scope :next_actions, :conditions => ["next_action > ?", Time.now ], :order => 'next_action ASC'
  
end
