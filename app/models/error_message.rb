# -*- encoding : utf-8 -*-
class ErrorMessage < ActiveRecord::Base
  
  validates :message, length: {minimum: 1, maximum: 255 }, allow_blank: true

  attr_accessible :name, :message


end

