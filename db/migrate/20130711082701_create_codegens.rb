# -*- encoding : utf-8 -*-
class CreateCodegens < ActiveRecord::Migration
  def change
    create_table :codegens do |t|
      t.string :name
      t.timestamps
    end
  end
end
