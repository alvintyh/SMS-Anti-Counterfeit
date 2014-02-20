class AddCol123 < ActiveRecord::Migration
  def up
  	add_column :doanh_nghieps, :dn_tat, :string
  	add_column :san_phams, :sp_tat, :string
  end

  def down
  end
end
