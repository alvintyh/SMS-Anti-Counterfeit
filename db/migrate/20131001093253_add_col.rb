class AddCol < ActiveRecord::Migration
  def up
  	add_column :san_phams, :so_giay_phep, :string
  end

  def down
  end
end
