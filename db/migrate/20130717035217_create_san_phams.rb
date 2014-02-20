# -*- encoding : utf-8 -*-
class CreateSanPhams < ActiveRecord::Migration
  def change
    create_table :san_phams do |t|
      t.string :name
      
      t.string :giay_phep
      t.string :noi_cap
      t.date :ngay_cap
      t.string :so_luong
      t.string :xuat_xu
      t.integer :doanh_nghiep_id
      
      t.timestamps
    end
  end
end
