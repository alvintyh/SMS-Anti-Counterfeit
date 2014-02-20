class CreatePhattems < ActiveRecord::Migration
  def change
    create_table :phattems do |t|
      t.integer :captem_id
      t.integer :san_pham_id

      t.timestamps
    end
  end
end
