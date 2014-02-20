# -*- encoding : utf-8 -*-
class Ptype < ActiveRecord::Base
  has_many :packages
  attr_accessible :name, :description
end
