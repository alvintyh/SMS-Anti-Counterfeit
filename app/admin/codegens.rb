# -*- encoding : utf-8 -*-
ActiveAdmin.register Codegen do
  menu :label => "Tem"
  

  index :title => "Bảng Tem" do
  	  selectable_column
	  column "Tem", :name #do |row|
	   	#link_to "#{row.name}", admin_codegen_path(row)
	  #end
	  column "Cập Nhật", :mark #do |task| 
	  	#status_tag #(task.mark ? "1" : "2"), (task.mark ?  :ok : :error)
	  #end
  end  

  filter :name, :label => "Tem"  
end
