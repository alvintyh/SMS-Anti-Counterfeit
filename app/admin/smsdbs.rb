# -*- encoding : utf-8 -*-
ActiveAdmin.register Smsdb do
  menu :label => "Lịch Sử Tra Cứu", :if => proc { current_admin_user.role == "admin" }

  index :title => "Lịch Sử Tra Cứu" do


  	#column "STT", :id

  	column "Thời Gian", :created_at do |row|
      row.created_at.strftime("%d-%m-%Y %H:%M:%S")
    end

  	column "Số Điện Thoại", :sdt



  	column "Mã Tra Cứu", :print_manager do |row|
      if row.print_manager.nil?
        row = "---"
      else
  		  row.print_manager.codegen_name
      end
  	end



  	#column "Lỗi", :error do |row|
  	#	link_to "#{row.error}", admin_smsdb_path(row)
  	#end
    column "Series", :series do |row|
      if row.print_manager.nil?
        row = "---"
      else
        row.print_manager.package.name
      end
    end
  	column "Sản Phẩm", :san_pham do |row|
  		if(row.print_manager.nil?)
  			row = "---"
  		else
  			if row.print_manager.package.captem.nil?
          row = "---"
        else
          if row.print_manager.package.captem.phattem.nil?
            row = "Chưa Phát cho Doanh Nghiệp"
          else
            row.print_manager.package.captem.phattem.san_pham.name
          end
        end
        #row.print_manager.package.captem.phattem.san_pham.name
  		end
  	end
    column "Doanh Nghiệp", :doanh_nghiep do |row|
      if(row.print_manager.nil?)
        row = "---"
      else
        if row.print_manager.package.captem.nil?
          row = "Chưa Cấp cho Đại Lý"
        else
          if row.print_manager.package.captem.phattem.nil?
            row = "---"
          else
            row.print_manager.package.captem.phattem.san_pham.doanh_nghiep.name
          end
        end
        #row.print_manager.package.captem.phattem.san_pham.name
      end
    end
    column "Đại Lý", :dai_ly do |row|
      if(row.print_manager.nil?)
        row = "---"
      else
        if row.print_manager.package.captem.nil?
          row = "Chưa Cấp cho Đại Lý"
        else
          row.print_manager.package.captem.dai_ly.name
        end
        #row.print_manager.package.captem.phattem.san_pham.name
      end
    end
  	
   column "" do |row|
       link_to("Xem", admin_smsdb_path(row))# + " | " + \
       #link_to("Xóa", admin_smsdb_path(row), :method => :delete, :confirm => "Are you sure?")
     end

  end
#attr_accessible :error, :lo, :print_manager, :sdt
  filter :sdt, :label => "Số Điện Thoại"
  
  #filter :print_manager, :as => :string, :label => "Mã Tra Cứu"
  #filter :lo, :label => "Số Series"


	show  do
    #render "dribble"
		panel "Chi tiết nội dung MO" do
		  attributes_table_for smsdb do
		    row("Trạng Thái") do |col|
          if col.error == "1"
            col = "Mã Tem sai cấu trúc"
          elsif col.error == "2"
            col = "Mã Tem Chưa Kích Hoạt"
          elsif col.error == "3"
            col = "Tin nhắn sai tổng đài"
          elsif col.error == "4"
            col = "Mã Tem đã bị Kích Hoạt"
          elsif col.error == "5"
            col = "Mã Tem Kích Hoạt Thành Cộng"
          else
            col.error
          end
        end
		    row("Số Điện Thoại") { smsdb.sdt }
		    row("Tin Nhắn Gửi Về") { smsdb.message }
		    row("Mã Tem") do |val|
          if val.print_manager.nil?
            val = "---"
          else 
            val.print_manager.codegen_name
          end
        end
		    row("Ngày tạo") do |m|
          m.created_at.strftime("%d-%m-%Y %H:%M:%S")
        end
			  row("Ngày chỉnh sửa") do |m|
          m.updated_at.strftime("%d-%m-%Y %H:%M:%S")
        end
		  end
		end
	end
	
	form do |f|
	    f.inputs "Nhập tin MT" do
	      f.input :error, :label => "Lỗi"
	      f.input :sdt, :label => "Số Điện Thoại"
	     # f.input :lo, :label => "Số Series"
	      f.input :print_manager, :label => "Số Pin"
	    end
	    f.buttons
	  end

end
