# -*- encoding : utf-8 -*-
class DaiLy < ActiveRecord::Base
  belongs_to :admin_user
  has_many :dangki_captems
  has_many :doanh_nghieps, :readonly => false
  has_many :captems
  attr_accessible :diachi, :email, :sdt, :name, :admin_user_id
end
