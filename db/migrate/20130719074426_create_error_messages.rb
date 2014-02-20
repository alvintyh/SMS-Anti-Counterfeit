# -*- encoding : utf-8 -*-
class CreateErrorMessages < ActiveRecord::Migration
  def change
    create_table :error_messages do |t|
      t.string :name
      t.text :message

      t.timestamps
    end
  end
end
