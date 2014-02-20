# -*- encoding : utf-8 -*-
ActiveAdmin.register Phattem do
  
  menu :label => "Thống Kê"

  index :title => "Báo Cáo" do

    
  	column "STT", :id 
  	
  	column "Sản Phẩm", :san_pham do |r|
  		r.san_pham.name
  	end
  	column "Ngày Cấp", :approve_at do |r|
      r.approve_at.to_date
    end
  	column "Số Lượng", :so_luong do |r|
  		r.captem.package.print_managers.count
  	end
  	
  	column("Series") do |sanpham|
        if (sanpham.nil?)
                    string = ""
                  else
                  string = "#{sanpham.captem.package.name}"
                  end
                  sanpham = string

                end 
  	column "Tra Cứu" do |r|
  		count = 0
  		r.captem.package.print_managers do |m|
  			count = m.kh
  		end#.count
  		r = count
  	end
  	
  end

  #index :as => :table, :default => true, phattems.all do |product|
   

  #end
  # controller do
  #   def index
  #     redirect_to manage_admin_phattem_path
  #   end
  # end

  # collection_action :manage do
  #   #@page_title = 'Categories'
  #   @phattems = Phattem.all
  # end
  filter :created_at, :label => "Ngày Cấp"

  show do
  	panel "Phat Tem cho Doanh Nghiệp" do
  		attributes_table_for phattem do
  			row("Tên Sản Phẩm") {phattem.san_pham.name}
  			rơw("Tên Doanh Nghiệp") {phattem.san_pham.doanh_nghiep.name}
  			row("Số Lượng Sản Phẩm") {phattem.san_pham.luong_lo}

  		end
  	end
  end


  form :label => "abc" do  |f|
	    f.inputs "Thông Tin Phat Tem" do
	      #f.input :doanh_nghiep, :label => "Tên Doanh Nghiệp", :collection => DoanhNghiep.where(:))#, :input_html => {:disabled => true}
	      #f.input :admin_user, :collection => AdminUser.where(:role => "norm").select {|n| n.doanh_nghiep.nil?}, :include_blank => false
	      f.input :san_pham, :collection => DangkiPhattem.where(:SanPham => current_admin_user.id).first.san_phams, :include_blank => false
	    end
	    
	    f.actions do
	    	f.action :submit, :label => "Câp Nhật Doanh Nghiệp"
	    	f.action :cancel, :label => "Bỏ qua"
	    end
	  end

end
