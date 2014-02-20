# -*- encoding : utf-8 -*-
class AdminUser < ActiveRecord::Base
  has_one :dai_ly
  has_one :doanh_nghiep, :readonly => false

  ROLES = %w(admin mode norm)
  ROLE_MODE = %w(norm)  #has_many :user

  #resourcify
  #rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  #accepts_nested_attributes_for :dai_ly, :allow_destroy => true
  #accepts_nested_attributes_for :doanh_nghiep, :allow_destroy => true

  #scope :user, AdminUser.joins(:roles).where(:roles => {:name => "norm"})
  #scope :mod, AdminUser.joins(:roles).where(:roles => {:name => "mode"})
  #scope :admin, AdminUser.joins(:roles).where(:roles => {:name => "admin"})
      
  # Setup accessible (or protected) attributes for your model

  attr_accessible :email, :password, :password_confirmation, :remember_me, :role
  #attr_accessible , :as => :admin
  # attr_accessible :title, :body

  #after_initialize :set_default_title
  #...
  #protected
  #  def set_default_title
  #     self.add_role "norm"
     
  #end
  def name
      return self.email
    end

  
end
