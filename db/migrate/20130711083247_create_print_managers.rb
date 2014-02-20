# -*- encoding : utf-8 -*-
class CreatePrintManagers < ActiveRecord::Migration
  def change
    create_table :print_managers do |t|
      t.integer :package_id
      t.string :codegen_name
      t.integer :kh, :default => 0
      t.timestamps
    end
  end
end
