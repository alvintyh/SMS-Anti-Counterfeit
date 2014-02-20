class DangkiPhattem < ActiveRecord::Base
  belongs_to :san_pham
  attr_accessible :luong_lo, :luong_sp, :name, :san_pham_id

  STATUS_CHUA = '0'
  STATUS_CAP  = '1'


#def status_tag
 #   case self.approve
  #    when STATUS_CHUA then :error
   #   when STATUS_CAP then :warning
      #when STATUS_PAID then :ok
    #end
  #end
#after_initialize :set_default_title
  #...
  #protected
    #def set_default_title
    #   self.approve = 0
  	#end
end
