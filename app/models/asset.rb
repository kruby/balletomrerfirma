class Asset < ActiveRecord::Base
  
  # has_attached_file   :photo, :styles => { :original => @image_500, :image_100 => @image_100, :image_200 => @image_200, :image_300 => @image_300, :image_50 => @image_50, :thumb => @thumb },
  #                     :url => "/uploads/assets/:id/:style/:basename.:extension",
  #                     :path => ":rails_root/public/uploads/assets/:id/:style/:basename.:extension"
  # 
  # before_post_process :image_orientation
  
  
  has_attached_file   :photo, 
                      :styles => {  :original => "599>x599",
                                    :thumb => "20>x20",
                                    :image_50 => "50>x50",
                                    :image_100 => "100>x100", 
                                    :image_200 => "200>x200", 
                                    :image_300 => "300>x300",
                                    :image_400 => "400>x400",
                                    :image_500 => "500>x500" }, 
                       :url => "/uploads/assets/:id/:style/:basename.:extension",
                       :path => ":rails_root/public/uploads/assets/:id/:style/:basename.:extension"
                
                       
 belongs_to :attachment, :polymorphic => true
 
 has_many :attachments, :dependent => :destroy
 
 private
 def image_orientation
   self.orientation = Paperclip::Geometry.from_file(self.data.to_file).horizontal? ? 'horizontal' : 'vertical'
   if self.orientation == 'horizontal'
     @image_500 = '500x500>'
     @image_100 = '100x100>'
     @image_200 = '200x200>'
     @image_300 = '300x300>'
     @image_50 = '50x50>'
     @thumb = '20x20>'     
   else
     @image_500 = '500>x500'
     @image_100 = '100>x100'
     @image_200 = '200>x200'
     @image_300 = '300>x300'
     @image_50 = '50>x50'
     @thumb = '20>x20'
   end
 end
  
 # def self.search(search, page)
 #   paginate  :per_page => 5, :page => page,
 #             #:conditions => ['parent_id is NULL'],
 #             :order => 'photo_updated_at DESC'
 # end
  

end
