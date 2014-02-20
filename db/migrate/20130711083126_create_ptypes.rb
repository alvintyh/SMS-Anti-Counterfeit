# -*- encoding : utf-8 -*-
class CreatePtypes < ActiveRecord::Migration
  def change
    create_table :ptypes do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
