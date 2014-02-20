# -*- encoding : utf-8 -*-
ActiveAdmin.register DangkiCaptem do
    #menu :label => "Mã Tem Cho Đại Lý", :priority => 4
    #name = "none"
    # if proc {current_admin_user.role == "mode"}
    #   name = "Xin Cấp Tem" 
    # else 
    #   name = "Duyệt Cấp Tem" 
    # end
    menu :priority => 6, :label => "Cấp Phát Đại Lý"
    
    #menu :if => price{current_admin_user.role == "admin" }, :label => price{I18n.t("ol")}
          
    #menu :if => proc {current_admin_user.role == "admin" }, :label => "Duyệt Cấp Tem"  

  #title "yêu cầu cấp tem"
  config.clear_action_items!
  
    action_item :only => [:index] do
      link_to "Thêm Mới", new_admin_dangki_captem_path()
    end

  index  :title => "Cấp Tem cho Đại Lý" do 
    column "STT", :id
    column "Đại Lý", :dai_ly
    column "Số Lượng Series", :luong_lo
    if current_admin_user.role == "mode"
      column "Trạng thái", :approve do |row|
        if row.approve == 0
          row = "Đang Chờ Cấp"
        else
          row = "Đã được Cấp"
        end

      end
    end

    #column "" 
      #link_to("Tickets", admin_san_pham_path(project))

    if current_admin_user.role == "admin"
      column "Xuất Tem" do |row|
        #row.id
        if row.approve == 0
          link_to( "Cấp Tem", cap_admin_dangki_captem_path(row), confirm: "Bạn Có Muốn Cấp Mã Series Cho Đại Lý?" )
        elsif row.approve == 1
          row = "Đã Cấp"
        end

        #button_to "boew", "admin/dangki_captem/updatecaptem", :method => :post, :confirm => "Are you sure?"
        #link_to("Sửa", edit_admin_dangki_phattem_path(row)) + " | " + \
        #link_to("Xóa", admin_dangki_phattem_path(row), :method => :delete, :confirm => "Are you sure?")
      end
    end
  end

  filter :dai_ly, :label => "Đại Lý"
  filter :luong_lo, :label => "Số Lượng"
  filter :approve, :label => "Trạng Thái"
  scope "Tất Cả", :all
  scope "Chờ Cấp", :kho do |row|
    row.where(:approve => DangkiPhattem::STATUS_CHUA)
  end

  scope "Đã Cấp", :in do |row|
    row.where(:approve => DangkiPhattem::STATUS_CAP)
  end

  show do
    panel "" do
      attributes_table_for dangki_captem do

        row("Sản Phẩm") {dangki_captem.dai_ly.name}
        row("Trạng Thái") {dangki_captem.approve}#{"#{Đã Cấp Mã}"}

      end
    end
  end

  collection_action :updatecaptem, :method => :post do
    #
    redirect_to admin_dangki_captem_path, :notice => "Syncing..."  
  end

  member_action :cap do
      @dkcaptem = DangkiCaptem.find(params[:id]) rescue nil
      date = DateTime.now
    unless @dkcaptem.nil?
      @dkcaptem.approve = 1
      @dkcaptem.approve_at = date
      @dkcaptem.save
      Package.where(:issued => 0).limit(@dkcaptem.luong_lo.to_i).each do |t|
         t.issued = 1
         t.save
         cap = Captem.new
         cap.dai_ly = @dkcaptem.dai_ly
         cap.approve_at = date
         cap.package = t
         cap.issued = 1
         cap.save
      end
    end
      redirect_to admin_dangki_captem_path(params[:id]), :notice => "Cấp Mã Cho Đại Lý Thành Công"
  end
  #sidebar :actions do
  #   button_to "boew", "dangki_captem/updatecaptem", :method => :post, :confirm => "Are you sure?"
  #end
  form do |f|
    #if current_admin_user.has_role? :mode
      f.inputs do
          f.input :dai_ly, :label => "Đại Ly", :collection => DaiLy.where(:admin_user_id => current_admin_user.id), :include_blank => false#=> {:admin_user => {:id => current_admin_user.id}}}
          f.input :luong_lo, :label => "Số Lượng" #, :label_method => :package
          #f.input :luong_lo, :label => "Loại Lô"
          #if current_admin_user.has_role #:mode
            #f.input :approve, :label => "Trạng Thái"
          #end
      end
      f.actions do
        f.action :submit, :label => "Câp Nhật Doanh Nghiệp" do 
          f.approve = 10
        end
        f.action :cancel, :label => "Bỏ qua"
      end 
  end


end
