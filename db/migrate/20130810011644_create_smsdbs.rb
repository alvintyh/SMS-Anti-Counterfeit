# -*- encoding : utf-8 -*-
class CreateSmsdbs < ActiveRecord::Migration
  def change
    create_table :smsdbs do |t|
      t.string :sdt
      t.string :error
      t.text :message
      t.integer :print_manager_id
      t.timestamps
    end
  end
end
