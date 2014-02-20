# -*- encoding : utf-8 -*-
class PrintManager < ActiveRecord::Base
  


  #belongs_to :codegen 
  belongs_to :package
  #belongs_to :san_pham

  has_many :smsdbs
  
STATUS_KHO = 0
STATUS_IN = 1
STATUS_PHAT = 2

  attr_accessible  :codegen_name, :kh, :package_id

 
end
