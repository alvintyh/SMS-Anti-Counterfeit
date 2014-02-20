class Dnfile < ActiveRecord::Base

  belongs_to :san_pham
  
  mount_uploader :file, DnfileUploader
  
  acts_as_url :file, limit: 100
  
  def to_param
    url
  end
  
	
   attr_accessible :file, :description
end
