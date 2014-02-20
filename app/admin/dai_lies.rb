# -*- encoding : utf-8 -*-
ActiveAdmin.register DaiLy do
	 menu :label => "Đại Lý", :priority => 1, :if => proc { current_admin_user.role == "admin" }
  

  	before_filter :skip_sidebar!, :only => :index

  	config.clear_action_items!
  
	  action_item :only => [:index] do
	    link_to "Đại Lý Mới", new_admin_dai_ly_path()
	  end
	  action_item :only => [:show] do
	    link_to "Sửa Đại Lý", edit_admin_dai_ly_path()
	  end
  
  index :title => "Đại Lý" do
  	column "STT", :id
  	column "Tên Đại Lý", :name do |row|
  		link_to "#{row.name}", admin_dai_ly_path(row)
  	end
  	column "Địa Chỉ", :diachi	
	column "Điện thoại", :sdt
  	
  	column "Email", :email
  	#column "Người Đại Diện", :ng_dai_dien do |row|
  	#		row.doanh_nghiep
  	#end
  	column "Số Lượng Doanh Nghiêp", :doanh_nghiep do |row|
  		link_to "#{row.doanh_nghieps.count}", admin_dai_ly_path(row)
  	end
  		#link_to "#{}" admin_dai_ly_path(resource)
  	#end
  	column "" do |row|
      link_to("Sửa", edit_admin_dai_ly_path(row)) + " | " + \
      link_to("Xóa", admin_dai_ly_path(row), :method => :delete, :confirm => "Are you sure?")
    end

  end

  
#attr_accessible :diachi, :email, :sdt, :name
  filter :name, :label => "Tên"
  filter :email, :label => "Email"

	show :title => :name do
		panel "Chi tiết Đại Lý" do
		  attributes_table_for dai_ly do
		    row("Tên Đại Lý") { dai_ly.name }
		    row("Email") { dai_ly.email }
		    row("Số Điện Thoại") { dai_ly.sdt }
		    row("Địa Chỉ") { dai_ly.diachi }
		    
		    row("Ngày tạo") do |m|
		    	m.created_at.strftime("%d-%m-%Y %H:%M:%S")
		    end
			row("Ngày chỉnh sửa") do |m|
				m.created_at.strftime("%d-%m-%Y %H:%M:%S")
			end
		  end
		end

		panel "Doanh Nghiệp" do
			table_for dai_ly.doanh_nghieps do |row|
				row.column("STT") {|m| m.id}
				row.column("Tên Doanh Nghiệp") {|m| m.name}
				row.column("Địa Chỉ") {|m| m.dia_chi}
				row.column("Địa Chỉ Giao Dịch") {|m| m.dia_chi_gd}			
				row.column("Mã Số Thuế") {|m| m.ma_so_thue}
				row.column("Điện Thoại") {|m| m.dien_thoai}
				row.column("Email") {|m| m.email}
				row.column("Người Đại Diện") {|m| m.ng_dai_dien}
			end
		end
	end
	
	form do |f|
	    f.inputs "Nhập Thông tin Đại Lý" do
	      f.input :name, :label => "Tên"
	      if f.object.id.nil?
	      	f.input :admin_user, :collection => AdminUser.where(:role => "mode").select {|n| n.dai_ly.nil?}, :include_blank => false
	      else

	      	f.input :admin_user#, :collection => f.object.admin_user, :include_blank => false
	      end
	      f.input :email, :label => "Email"
	      f.input :sdt, :label => "Số Điện Thoại"
	      
	      f.input :diachi, :label => "Địa Chỉ"
	    end
	    f.buttons
	  end
  
end
