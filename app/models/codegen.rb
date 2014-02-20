# -*- encoding : utf-8 -*-
class Codegen < ActiveRecord::Base
  has_one :print_manager
  attr_accessible :name, :mark

 
end
