class CreateCaptems < ActiveRecord::Migration
  def change
    create_table :captems do |t|
      t.integer :package_id
      t.integer :dai_ly_id
      t.integer :issued, :default => 0
      t.timestamps
    end
  end
end
