# -*- encoding : utf-8 -*-
class Smsdb < ActiveRecord::Base
  belongs_to :print_manager
  attr_accessible :error, :print_manager_id, :sdt
end
