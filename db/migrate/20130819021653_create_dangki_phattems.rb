class CreateDangkiPhattems < ActiveRecord::Migration
  def change
    create_table :dangki_phattems do |t|
      t.string :name
      t.integer :san_pham_id
      t.integer :luong_lo
      t.integer :approve, :default => 0
      t.timestamps
    end
  end
end
