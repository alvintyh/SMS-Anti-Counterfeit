# -*- encoding : utf-8 -*-
class DoanhNghiep < ActiveRecord::Base
  has_many :san_phams
  belongs_to :dai_ly, :readonly => false
  belongs_to :admin_user, :readonly => false
  #belongs_to :user
  #accepts_nested_attributes_for :admin_user, :allow_destroy => true

  attr_accessible :dn_tat, :email, :dia_chi, :dien_thoai, :giao_dich, :ma_so_thue, :phap_ly, :name, :admin_user_id, :dai_ly_id, :ng_dai_dien, :dia_chi_gd
end
