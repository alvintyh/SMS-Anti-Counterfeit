# -*- encoding : utf-8 -*-
ActiveAdmin.register ErrorMessage do
  menu :label => "SMS MT"
  
  index do

#  	column "Tên",  do |row|
#  		link_to "#{row.name}", admin_error_message_path(row)
 # 	end

  	column "Nội dung tin nhắn", :message

  	column "Sửa chữa" do |row|
      link_to("Sửa", edit_admin_error_message_path(row)) + " | " + \
      link_to("Xóa", admin_error_message_path(row), :method => :delete, :confirm => "Are you sure?")
    end

  end

#  filter :name, :label => "Tên"
  filter :message, :label => "Nội dung"


	show :title => :id do
		panel "Chi tiết nội dung MT" do
		  attributes_table_for error_message do
		   # row("Tên") { error_message.name }
		    row("Nội dụng tin nhắn") { error_message.message }
		    row("Ngày tạo") { error_message.created_at }
			row("Ngày chỉnh sửa") { error_message.updated_at }
		  end
		end
	end
	
	form do |f|
	    f.inputs "Nhập tin MT" do
	     # f.input :name, :label => "Tên"
	      f.input :message, :label => "Nội dung MT"
	    end
	    f.buttons
	  end

end
