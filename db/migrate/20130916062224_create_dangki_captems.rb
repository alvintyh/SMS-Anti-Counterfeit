class CreateDangkiCaptems < ActiveRecord::Migration
  def change
	create_table :dangki_captems do |t|
      t.string :name
      t.integer :dai_ly_id
      t.integer :luong_lo
      t.integer :approve, :default => 0
      t.timestamps
        end
  end
end
