class AddColCaptem < ActiveRecord::Migration
  def up
  	add_column :captems, :approve_at, :datetime
  	add_column :dangki_captems, :approve_at, :datetime
  	add_column :phattems, :approve_at, :datetime
  	add_column :dangki_phattems, :approve_at, :datetime
  


  end

  def down
  end
end
