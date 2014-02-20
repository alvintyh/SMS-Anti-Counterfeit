# -*- encoding : utf-8 -*-
ActiveAdmin.register DoanhNghiep do
  menu :priority => 2, :label => "Doanh Nghiệp", :if => proc { current_admin_user.role != "norm" }
  before_filter :skip_sidebar!, :only => :index
  


  index :title => "Doanh Nghiệp" do

  	column "STT", :id
  	column "Tên Doanh Nghiệp", :name do |row|
  		link_to "#{row.name}", admin_doanh_nghiep_path(row)
  	end

  	if(current_admin_user.role == "admin")
  		column "Thuộc Đại Lý", :dai_ly 
  	end
  	column "Địa chỉ", :dia_chi
  	column "Địa chỉ giao dịch", :dia_chi_gd
  	
  	column "Điện thoại", :dien_thoai
  	column "Mã Số Thuế", :ma_so_thue
  	
  	column "Email", :email
  	column "Người Đại Diện", :ng_dai_dien
  	#column "Bản Scan Pháp Lý", :phap_ly

  	column "" do |row|
      link_to("Sửa", edit_admin_doanh_nghiep_path(row)) + " | " + \
      link_to("Xóa", admin_doanh_nghiep_path(row), :method => :delete, :confirm => "Are you sure?")
    end

  end

  filter :name, :label => "Tên"
  

	show :title => :name do

		panel "Hồ Sơ Doanh Nghiệp" do
	    	attributes_table_for doanh_nghiep do
	      	    row("Tên Doanh Nghiệp") { doanh_nghiep.name }
	      	    row("Tên Viết Tắt"){ doanh_nghiep.dn_tat }
			    row("Địa Chỉ") { doanh_nghiep.dia_chi }
			    row("Địa Chỉ Giao Dịch") { doanh_nghiep.dia_chi_gd }
			    
			    row("Số Điện Thoại") { doanh_nghiep.dien_thoai }
			    row("Mã Số Thuế") { doanh_nghiep.ma_so_thue }
			    row("Người Đại Diện") { doanh_nghiep.ng_dai_dien }
			    #row("Pháp Lý") { doanh_nghiep.phap_ly }
			   
			#    row("Ngày tạo") { doanh_nghiep.created_at }
			#	row("Ngày chỉnh sửa") { doanh_nghiep.updated_at }

		    	end

    	end
    	panel "Sản Phẩm" do
			table_for doanh_nghiep.san_phams do |row|
				row.column("stt") {|task| task.id}
				row.column("Tên Sản Phẩm") do |task|
					link_to "#{task.name}", admin_san_pham_path(task.id)
				end
				row.column("Xuất Xứ") { |task| task.xuat_xu}
				row.column("Số Cấp Phép") {|task| task.giay_phep}
				row.column("Nơi Cấp Phép") {|task| task.noi_cap}
				row.column("Số Lượng Mã Tra Cứu") do |task|
					task.phattems.count*60
				end
				row.column("Mã Series") do |task| 
					if task.phattems.first.nil?
						string = ""
					else
						string = "#{task.phattems.first.captem.package.name}"
					end

					if task.phattems.last.nil?
						string1 = ""
					else
						string1 = "#{task.phattems.last.captem.package.name}"
					end
					task = string + " " + string1
				end

			end
		end
	
    	#panel 'Comments' do
      	#	attributes_table_for doanh_nghiep.san_phams do
        #	rows :name#, :ngay_cap
      	#	end
    	#end
		#panel "Thông Tin Chung" do
		#  attributes_table_for doanh_nghiep do
		#    row("Tên") { doanh_nghiep.name }
		   
		#    row("Địa Chỉ") { doanh_nghiep.dia_chi }
		#    row("Số Điện Thoại") { doanh_nghiep.dien_thoai }
		#    row("Mã Số Thuế") { doanh_nghiep.ma_so_thue }
		#    row("Giao Dịch") { doanh_nghiep.giao_dich }
		#    row("Pháp Lý") { doanh_nghiep.phap_ly }
		   
		#    row("Ngày tạo") { doanh_nghiep.created_at }
		#	row("Ngày chỉnh sửa") { doanh_nghiep.updated_at }
		#  end
		#end
	end
	
	form do |f|
	    f.inputs "Nhập Thông Tin" do
	      f.input :name, :label => "Tên Doanh Nghiệp"#, :input_html => {:disabled => true}
	      f.input :dn_tat, :label => "Tên Viết tắt"
	      #if f.object.id.nil?
	      #	f.input :admin_user, :collection => AdminUser.where(:role => "norm").select {|n| n.doanh_nghiep.nil?}, :include_blank => false
	      #else 
	      	#f.object.admin_user = AdminUser.where(:id => current_admin_user.id).first
	      	f.input :admin_user, :label => "Người Dùng"#, :collection => AdminUser.where(:id => current_admin_user.id), :include_blank => false
	      #end
	      #f.object.dai_ly = DaiLy.where(:admin_user_id => current_admin_user.id).first
	      f.input :dai_ly, :label => "Đại Lý"#, :collection => DaiLy.where(:admin_user_id => current_admin_user.id), :include_blank => false
	      f.input :dien_thoai, :label => "Số Điện Thoại"
	      f.input :email, :label => "Email"	 
	      f.input :ma_so_thue, :label => "Mã Số Thuế"
	      f.input :ng_dai_dien, :label => "Người Đại Diện"
	      f.input :dia_chi, :label => "Địa Chỉ"
	      f.input :dia_chi_gd, :label => "Địa Chi Giao Dịch"	      
	      #f.input :phap_ly, :label => "Pháp Lý"
	    end
	    f.actions
	    	
	  end
	  #:dien_thoai, :giao_dich, :ma_so_thue, :phap_ly, :name, :viet_tat

end
