# -*- encoding : utf-8 -*-

ActiveAdmin.register Captem do
  

  menu :priority => 6, :label => "Kho Mã Tem", :if => proc { current_admin_user.role == "mode" }
  

  index do
  	column "STT", :id
  	column "Series", :package do |row|
  		row.package.name
  	#
  	end

  	column "Ngày Cấp", :approve_at do |row|
      row.approve_at.strftime("%d-%m-%Y %H:%M:%S")
    end


  	
  	column "Tên Doanh Nghiệp", :doanh_nghiep do |row|
  		if row.phattem.nil?
  			row = ""
  		else
  			row.phattem.san_pham.doanh_nghiep.name
  		end
  	end

  	column "Tên Sản Phẩm", :san_pham do |row|
  		if row.phattem.nil?
  			row = ""
  		else
  			row.phattem.san_pham.name
  		end
  	end
  end


  filter :package, :label => "Series"
  filter :approve_at, :label => "Ngày Cấp"
  scope "Tất Cả", :all
  #scope "Tồn Kho", :ton do |row|
  #	row.package.where(:approve => Captem::STATUS_CHUA)
  #end
  scope "Tồn Kho", :kho do |row|
    row.where(:issued => Captem::STATUS_CAP)
  end

  scope "Đã Phát", :in do |row|
    row.where(:issued => Captem::STATUS_PHAT)
  end
  
end
