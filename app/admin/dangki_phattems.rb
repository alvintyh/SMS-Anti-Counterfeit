# -*- encoding : utf-8 -*-
ActiveAdmin.register DangkiPhattem do
  menu :label => "Cấp Phát Doanh Nghiệp", :priority => 5
  #title "yêu cầu cấp tem"


  config.clear_action_items!
  
  action_item :only => [:index] do
    link_to "Đăng Ký Tem Mới", new_admin_dangki_phattem_path()
  end
  index  :title => "Mã Tem Cho Doanh Nghiệp" do 
    column "STT", :id
    column "Sản phẩm", :san_pham do |row|
      link_to("#{row.san_pham.name}", admin_dangki_phattem_path(row))
    end
    column "Doanh Nghiệp", :doanh_nghiep do |d|
      d.san_pham.doanh_nghiep.name
    end
    #column "Số Lượng", :luong_sp
    column "Ngày Cấp", :approve_at do |row|
      if(row.approve_at.nil?)
        row = "---"
      else
        row.approve_at.strftime("%d-%m-%Y %H:%M:%S")
      end
    end
    column "Số lượng Series", :luong_lo
    if current_admin_user.role == "norm"
      column "Trạng Thái", :approve do |row|
        if row.approve == 0
          row = "Đang Chờ Phát"
        else 
          row = "Đã Được Phát"
        end
      end
    end

    if current_admin_user.role == "mode"
      column "Xuất Tem" do |row|
        #row.id
        if row.approve == 0
          link_to( "Phát Tem", phat_admin_dangki_phattem_path(row), confirm: "Bạn Đồng Ý Phát Mã Tem Cho Doanh Nghiệp" )
        elsif row.approve == 1
          row = "Đã Phát"
        end
      end
    end
     #{|priority| status_tag(priority.approve), color_for_weight(priority.approve) }
    #column "" status_tag (task.is_done ? "Done" : "Pending"), (task.is_done ? :ok : :error)
      #link_to("Tickets", admin_san_pham_path(project))


    #if current_admin_user.role == "mode"
      #column "" do |row|
        #link_to( "Revive", revive_admin_dangki_phattem_path(row.id), confirm: "Are you sure you want to revive this milestone?" )
      
        #link_to("Chờ Duyệt", edit_admin_dangki_phattem_path(row))
        #@approve = DangkiPhattem.find(row)
        #@approve.approve = 2
     # end
    #end
    
    #column "Sửa chữa" do |row|
    ##  link_to("Sửa", edit_admin_dangki_phattem_path(row)) + " | " + \
    #  link_to("Xóa", admin_dangki_phattem_path(row), :method => :delete, :confirm => "Are you sure?")
    #end

  end


  member_action :phat do
      @dkcaptem = DangkiPhattem.find(params[:id]) rescue nil
      date = DateTime.now
    unless @dkcaptem.nil?
      @dkcaptem.approve = 1
      @dkcaptem.approve_at = date
      @dkcaptem.save
      Captem.where(:issued => 1).limit(@dkcaptem.luong_lo.to_i).each do |t|
         t.issued = 2
         t.package.issued = 2
         t.save
         phat = Phattem.new
         phat.san_pham = @dkcaptem.san_pham
         phat.approve_at = date
         phat.captem = t
         #phat.issued = 1     
         phat.save
      end
    end
      redirect_to admin_dangki_phattem_path(params[:id]), :notice => "Mã Tem Phát Thành Công"
  end
  
  scope "Tất Cả", :all
  scope "Chờ Phát", :kho do |row|
    row.where(:approve => DangkiPhattem::STATUS_CHUA)
  end

  scope "Đã Phát", :in do |row|
    row.where(:approve => DangkiPhattem::STATUS_CAP)
  end
  
  filter :san_pham, :label => "Sản Phẩm" do |f|

  end

  show :title => "Đăng Kí Phát Tem của Doanh Nghiệp" do
    panel "Chi Tiết Xin Phát Tem" do
      attributes_table_for dangki_phattem do

        row("Sản Phẩm") {dangki_phattem.san_pham.name}
        row("Doanh_Nghiệp") {dangki_phattem.san_pham.doanh_nghiep.name}
        row("Xuất Xứ") {dangki_phattem.san_pham.xuat_xu}
        row("Giấy Phép"){dangki_phattem.san_pham.giay_phep}
        row("Đơn vị Cấp Phép") {dangki_phattem.san_pham.noi_cap}
        row("Số Lượng") {dangki_phattem.luong_lo}

      end
    end
  end


  form do |f|
    #if current_admin_user.has_role? :mode
      f.inputs do
          f.input :san_pham, :label => "Sản Phẩm", :collection => DoanhNghiep.where(:admin_user_id => current_admin_user.id).first.san_phams, :include_blank => false#=> {:admin_user => {:id => current_admin_user.id}}}
          f.input :luong_lo, :label => "Số Lượng" #, :label_method => :package
          #f.input :luong_lo, :label => "Loại Lô"
          #if current_admin_user.has_role #:mode
          
          f.input :approve, :label => "Trạng Thái", :input_html => {:value => 0, :disabled => true}
          #end
      end
      f.buttons
  end

  member_action :printed, :method => :put do
    yeucau = DangkiPhattem.find(param[:id])
    yeucau.approve = 2
    #redirect_to  {:action => :show}
  end

end
