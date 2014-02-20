# -*- encoding : utf-8 -*-
class CreateDoanhNghieps < ActiveRecord::Migration
  def change
    create_table :doanh_nghieps do |t|
      t.string :name
      t.string :ma_so_thue
      t.text :dia_chi
      t.text :dia_chi_gd
      t.integer :dien_thoai
      t.string :email
      t.string :ng_dai_dien
      
      t.integer :admin_user_id
      t.integer :dai_ly_id
      t.timestamps
    end
  end
end
