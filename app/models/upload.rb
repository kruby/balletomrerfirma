class Upload < ActiveRecord::Base
  
  has_attached_file :photo,
    :url => "uploads/files/:basename.:extension",
    :path => ":rails_root/public/uploads/files/:basename.:extension"
  
end
