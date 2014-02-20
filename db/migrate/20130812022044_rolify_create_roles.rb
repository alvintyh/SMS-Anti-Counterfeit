# -*- encoding : utf-8 -*-
class RolifyCreateRoles < ActiveRecord::Migration
    # Create a default user
    #Role.create!(:name => 'moderator') if direction == :up
    #Role.create!(:name => 'admin') if direction == :up
  

  def change
    create_table(:roles) do |t|
      t.string :name
      t.references :resource, :polymorphic => true

      t.timestamps
    end

    create_table(:admin_users_roles, :id => false) do |t|
      t.references :admin_user
      t.references :role
    end

    add_index(:roles, :name)
    add_index(:roles, [ :name, :resource_type, :resource_id ])
    add_index(:admin_users_roles, [ :admin_user_id, :role_id ])
  end
end
