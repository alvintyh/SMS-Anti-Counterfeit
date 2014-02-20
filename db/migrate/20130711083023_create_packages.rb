# -*- encoding : utf-8 -*-
class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :name
      t.integer :ptype_id
      t.integer :issued, :default => 0

      t.timestamps
    end
  end
end
