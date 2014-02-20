# -*- encoding : utf-8 -*-
class SanPham < ActiveRecord::Base
  belongs_to :doanh_nghiep
  has_many :print_managers
  has_many :dangki_phattems
  has_many :phattems
  has_one :dnfile
  attr_accessible :doanh_nghiep_id, :ma_cap_phep, :giay_phep, :ngay_cap, :so_luong, :name, :xuat_xu, :noi_cap, :dnfile_attributes, :sp_tat

  # acts_as_url :name, limit: 100
  
  # def to_param
  #   url
  # end
  accepts_nested_attributes_for :dnfile
  #nested_attribute
  #scope :owned_by, lambda { |user| where("admin_users.id = ?", user.id) }
end
