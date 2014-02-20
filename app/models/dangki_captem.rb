class DangkiCaptem < ActiveRecord::Base
  belongs_to :dai_ly
  # attr_accessible :title, :body
  attr_accessible :name, :dai_ly_id, :luong_lo
end
