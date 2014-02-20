class AddColPm < ActiveRecord::Migration
  def up
  	add_column :print_managers, :printed, :integer, :default => 0
  end

  def down
  end
end
