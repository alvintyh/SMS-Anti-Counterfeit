# -*- encoding : utf-8 -*-
ActiveAdmin.register PrintManager do
  
  menu false #:label => "Tem", :if => proc { current_admin_user.role != "norm" }
  #filter :package, :label => "Mã Lô"
  #filter :codegen_name, :label => "Mã Tem"

  scope "tất cả", :all, :default => true
  scope "tem kho", :kho do |row|
    row.where(:kh => PrintManager::STATUS_KHO)
  end

  scope "tem in", :in do |row|
    row.where(:kh => PrintManager::STATUS_IN)
  end
  
  scope "phát tem", :phat do |row|
    row.where(:kh => PrintManager::STATUS_PHAT)
  end
  

  index :title => "Kho Lô/Tem" do
  	selectable_column
  	
  	column "Mã Tem", :codegen_name do |row|
      link_to "#{row.codegen_name}", admin_print_manager_path(row)
    end
  	column "Series", :package do |row|
      link_to "#{row.package.name}", admin_print_manager_path(row)
    end

  	#column "Loại Series", :ptype

  	column "Trạng thái", :kh #do |row|
    #  status_tag row.printed, row.status_tag
  	#end
     column "Sửa chữa" do |row|
      link_to("Sửa", edit_admin_print_manager_path(row))
    #  link_to("Sửa", edit_admin_print_manager_path(row)) + " | " + \
    #  link_to("Xóa", admin_print_manager_path(row), :method => :delete, :confirm => "Are you sure?")
    end

  end

  show :title => :codegen_name do
    panel "Chi Tiết Tem" do
      attributes_table_for print_manager do
        row("Mã Tem") {print_manager.codegen_name}
        row("Series") {print_manager.package.name}
        row("Kíck Hoạt") {print_manager.kh}
        
      end
    end


  end



  form do |f|
    f.inputs "Add Tem" do 
    
     f.input :kh

    
   end
     f.actions
  end


end
