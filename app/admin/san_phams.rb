# -*- encoding : utf-8 -*-
ActiveAdmin.register SanPham do
  
  #if @san_pham == "norm"
  menu :label => "Sản Phẩm", :priority => 3, :if => proc { current_admin_user.role == "norm" }
  #else 
  #	menu :label => "san pham"
  #end
  before_filter :skip_sidebar!, :only => :index
  config.clear_action_items!
	#actions :all, :except => [:new]
  #actions :all, :except => [:new]

  index :title => "Sản Phẩm" do

  	
  	column "Tên Sản Phẩm", :name do |row|
  		link_to "#{row.name}", admin_san_pham_path(row)
  	end
  	#column "DN", :doanh_nghiep
  	
  	#column "Xuất Xứ", :xuat_xu
  	#column "Giấy Phép", :giay_phep
  	#column "Nơi Cấp Phép", :noi_cap
  	column "Ngày Cấp", :ngay_cap do |m|
  		m.ngay_cap#.strftime("%d-%m-%Y %H:%M:%S")
  	end
  	
  	column "Số Lượng", :luong_lo do |row|
  		row.phattems.count
  	end

  	column("Series Đầu") do |sanpham|
        if (sanpham.phattems.first.nil?)
                    string = ""
                  else
                  string = "#{sanpham.phattems.first.captem.package.name}"
                  end
                  sanpham = string

                end 
    column("Series Cuối") do |sanpham|
                  if (sanpham.phattems.last.nil?)
                    string = ""
                  else
                  string = "#{sanpham.phattems.last.captem.package.name}"
                  end
                  sanpham = string

                end 
                
  	column "Nơi Cấp", :noi_cap
  	#column "Sửa chữa" do |row|
      #link_to("Sửa", edit_admin_san_pham_path(row)) + " | " + \
      #link_to("Xóa", admin_san_pham_path(row), :method => :delete, :confirm => "Are you sure?")
      #link_to("phattem", admin_dangki_phattems_path(row))
    #end

  end
 #attr_accessible :san_pham_id, :ma_cap_phep, :ngay_cap, :so_luong, :_san_pham, :xuat_xu, :sms_trave
  filter :name, :label => "Tên Sản Phẩm"
  #filter :approve_at, :label => "Tên"

  action_item :only => [:show] do 
    link_to "Cấp Mã Mới", admin_dangki_phattems_path()
  end

  action_item :only => [:show] do 
    link_to "Sửa Sản Phẩm", edit_admin_san_pham_path()
  end



  action_item :only => [:index] do
  	link_to "Sản Phẩm Mới", new_admin_san_pham_path()

  end


  

	show :title => :name do
		panel "Chi tiết Sản Phẩm" do
		  attributes_table_for san_pham do
		    #row("Doanh Nghiệp") { san_pham.doanh_nghiep.name }

		    row("Tên Sản Phẩm") { san_pham.name }
		    		    row("Tên Viết Tắt") { san_pham.sp_tat }
		    row("Doanh Nghiệp") do |m|
		    	link_to "#{san_pham.doanh_nghiep.name}", admin_doanh_nghiep_path(san_pham.doanh_nghiep.id)
		    end
		    row("Xuất Xứ") { san_pham.xuat_xu }
		    row("Số Giấy Phép") { san_pham.giay_phep}
		    row("Giấy Phép") do |m|
				if m.dnfile.nil?
					m = "---"
				else
			    	link_to "#{m.dnfile.description}", admin_dnfile_path(m.dnfile.id) 
			    end
		    end
		    
		    row("Đơn Vị Cấp Phép") { san_pham.noi_cap}
		    

		    row("Số Series") do |phat|
		    	
		    	if (phat.phattems.first.nil?)
                    string2 =  ""
                  else
                  string1 = "#{phat.phattems.first.captem.package.name}"
                  end
                  

    		    if (phat.phattems.last.nil?)
                    string2= ""
                  else
                  string2 = "#{phat.phattems.last.captem.package.name}"
                  end
                  phat = string1.to_s + " to "  + string2.to_s


		    end
		    row("Số Lượng") { san_pham.phattems.count }
		    row("Ngày Kích Hoạt") { san_pham.created_at.strftime("%d-%m-%Y %H:%M:%S") }
		    
		    #row("Ngày tạo") { san_pham.created_at }
			#row("Ngày chỉnh sửa") { san_pham.updated_at }
		  end
		end

		panel "Thống kê" do
			table_for san_pham.phattems.order("approve_at DESC").group("time(approve_at)") do |row|
					count = 0
					row.column("stt") {count = count + 1} 
					row.column("Ngày Cấp Mã") {|task| task.created_at.strftime("%d-%m-%Y %H:%M:%S")}
					row.column("Số Lượng Mã") {|task| Phattem.where(:approve_at => task.approve_at).count}
					row.column("Series Đầu") { |task| Phattem.where(:approve_at => task.approve_at).first.captem.package.name}
					row.column("Series Cuối") {|task| task.captem.package.name}
					row.column("Số Lượng Tra Cứu") do |task|
						count = 0
						Phattem.where(:approve_at => task.approve_at).each do |phat|
							phat.captem.package.print_managers.each do |pm|
								count = count + pm.kh
							end
						end
						link_to "#{count}", admin_baocao_path(:date => task.approve_at)
					end
									#row.column("Số Lần Tra Cứu") {|task| task.count}
			
			end
			#render :partial => "smsdbs/show"
			#text_node (render :partial => "drib")#, :locals => { :san_pham => san_pham })
		end
	end
	
	action_item only: [:show] do
    #if can? :advanced_edit, resource
      #link_to "Move", drib_san_pham_path()#drib_san_pham_path(resource)
    #end
  	end
  

	form do |f|
	    f.inputs "Nhập Chi Tiết Sản Phẩm" do
	      f.input :name, :label => "Tên Sản Phẩm"
	      f.input :sp_tat, :label => "Tên Viết Tắt"

	      f.input :doanh_nghiep, :label => "Doanh Nghiệp", :collection => DoanhNghiep.where(:admin_user_id => current_admin_user.id), :include_blank => false #,:disabled => true}
	      f.input :so_luong, :label => "Số Lượng Sản Phẩm"
	      f.input :xuat_xu, :label => "Xuất Xứ"#, :default => "trung"
	      f.input :giay_phep, :label => "Số Giấy Phép"
	      f.input :noi_cap, :label => "Nơi Cấp"
	      f.input :ngay_cap, :label => "Ngày Cấp"
	      f.input :so_luong, :label => "Số Lượng"#{}"Số Lượng Sản Phẩm"
	    
	      end

		f.inputs "Giấy Phép", :for => [:dnfile, f.object.dnfile || Dnfile.new] do |meta_form|
		  meta_form.input :file, :label => "Đăng tải"
		  meta_form.input :description, :label => "Chi tiết tệp tin"

		end
	    f.buttons
	  end
end
