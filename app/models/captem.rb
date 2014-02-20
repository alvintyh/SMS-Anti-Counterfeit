class Captem < ActiveRecord::Base
  belongs_to :dai_ly
  belongs_to :package
  has_one :phattem
  attr_accessible :dai_ly_id, :package_id


  STATUS_CHUA = '0'
  STATUS_CAP  = '1'
  STATUS_PHAT = '2'

end
