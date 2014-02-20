# -*- encoding : utf-8 -*-
ActiveAdmin.register Package do
	menu :label => "Quản Lý Tem", :priority => 5
	
	index :title => "Thống kê Kho Tem" do
		column "Số Series" do |row|
			link_to "#{row.name}", admin_package_path(row)
		end

		column "Loại Tem", :ptype_id do |row|
			(row.ptype_id*1000).to_s + " VND"
		end 
		column "Ngày Cấp", :created_at do |row|
			row.created_at.strftime("%d-%m-%Y")

		end

		

		
		#column "Chi Tiết", :description
	end  
	scope "Tất Cả", :all, :default => true
  scope "Tem trong Kho", :kho do |row|
    row.where(:issued => PrintManager::STATUS_KHO)
  end
  scope "Cấp Cho Đại Lý", :in do |row|
    row.where(:issued => PrintManager::STATUS_IN)
  end
  
  scope "Cấp Cho Doanh Nghiệp", :phat do |row|
    row.where(:issued => PrintManager::STATUS_PHAT)
  end
  
  show do
  	panel "Chi Tiết Series Tem" do
  		attributes_table_for package do
  			row("Mã Series Tem") {package.name}
  			row("Loại Tem") {package.ptype_id}
  			row("Ngày Cấp") {package.created_at.strftime("%d-%m-%Y")}

  		end
  	end

	panel "Mã Tem thuộc Series" do
      table_for package.print_managers do |row|
     	row.column("stt") {|task| task.id}
		row.column("Mã Tem") do |task|
			link_to "#{task.codegen_name}", admin_print_manager_path(task.id)
		end
		row.column("Ngày Cấp") do |task|
			if task.created_at.nil?
				task = "---"
			else
				task.created_at.strftime("%d-%m-%Y")
			end
		end
		row.column("Số lần Kích hoạt") do |task|
			task.kh
		end

      end
    end

  end


	filter :name, :label => "Series"
	filter :ptype_id, :label => "Loại Series"
	filter :created_at, :label => "Ngày Cấp"
end