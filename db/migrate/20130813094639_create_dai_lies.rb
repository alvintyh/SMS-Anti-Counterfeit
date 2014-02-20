# -*- encoding : utf-8 -*-
class CreateDaiLies < ActiveRecord::Migration
  def change
    create_table :dai_lies do |t|
      t.string :name
      t.text :diachi
      t.string :email
      t.string :sdt
      t.integer :admin_user_id
      t.timestamps
    end
  end
end
