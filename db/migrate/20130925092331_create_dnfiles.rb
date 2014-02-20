class CreateDnfiles < ActiveRecord::Migration
  def change
    create_table :dnfiles do |t|
      t.string :file
      t.text :description
      t.string :url
      t.integer :san_pham_id
      t.timestamps
    end

    #add_index "project_files", ["project_id"], :name => "index_project_files_on_project_id"
  	#add_index "project_files", ["url"], :name => "index_project_files_on_url"
    add_index "dnfiles", ["san_pham_id"], :name => "index_dnfiles_on_san_pham_id"
  	add_index "dnfiles", ["url"], :name => "index_dnfiles_on_url"
  end
end
