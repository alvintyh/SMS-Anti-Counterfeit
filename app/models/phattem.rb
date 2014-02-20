class Phattem < ActiveRecord::Base

	belongs_to :captem
	belongs_to :san_pham	
  attr_accessible :captem_id, :san_pham_id
end
