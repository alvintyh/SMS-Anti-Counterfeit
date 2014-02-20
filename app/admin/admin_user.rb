# -*- encoding : utf-8 -*-
ActiveAdmin.register AdminUser do#, :namespace => "lol" do
  
  menu  :label => "Quản Trị"

  #menu :if => proc{ can?(:manage, AdminUser) }

  #authorize! :manage, AdminUser
  #controller.authorize_resource 
      #scope :all#, :default => true

      #scope "Người Sử Dụng", :user, :if => proc {current_admin_user.has_role? :mode}  do
        #AdminUser.user
      #end
      #scope "Cấp Phát", :mode, :default => true, :if => proc {current_admin_user.has_role? :mode} do
      #  AdminUser.mod
      #end
      #scope "Người Sử Dụng", :useradmin, :if => proc {current_admin_user.has_role? :admin} do
      #  AdminUser.user
      #end
   #row.where(:roles => "admin") 
  #end
  #scope :film_makers, -> { joins(:roles).where(roles: { name: 'mode' }) }
  #scope :loluser, :if => proc{ current_admin_user.has_role? "mode" } do |row|
  #  row.roles.where(:name => "mode").map{ |role| role.name}.join(' ')
  #end
  before_filter :skip_sidebar!, :only => :index

  index :title => "Quản Trị Đăng Nhập" do                             
    column "Đăng Nhập", :email do |row|
      link_to "#{row.email}", admin_admin_user_path(row)
    end
    #column :role
    #column :role, :sortable => :role do |user|
    #  div :class => "Role" do
    #    user.roles.map{ |role| role.name}.join(' ')
    #  end
    #end          
    
    column "Thuộc Đại Lý", :dai_ly
    column "Doanh Nghiệp", :doanh_nghiep
    column "Lần đăng nhập cuối", :last_sign_in_at  do |row|
      row.last_sign_in_at
    end         
    column "Số lần đăng nhập", :sign_in_count
    column "Chức Vụ", :role      
    default_actions                   
  end                                  

  show do
    panel "Chi tiết Thông tin Đăng Nhập" do
      attributes_table_for admin_user do
        row("Email") { admin_user.email }
        row("Chức vụ") { admin_user.role }
        row("DaiLy") {admin_user.dai_ly}
                row("Doanh nghiep") {admin_user.doanh_nghiep}
        row("Số Lần Đăng Nhập") { admin_user.sign_in_count}
        row("Lần Cuối Thay Mật Khẩu") do |m|
          m.reset_password_sent_at
        end 
        row("Lần Cuối Đăng Nhập") do |m| 
          m.last_sign_in_at.strftime("%d-%m-%Y")
        end
        row("IP Lần Cuối Đăng Nhập") do |m| 
          m.last_sign_in_ip
        end
        row("Tài Khoản Tạo Từ Ngày") do |m|
          m.updated_at.strftime("%d-%m-%Y %H:%M:%S")
        end
        #row("Chức Vụ") { admin_user.role}
        # if current_admin_user.role == "norm"
        #   panel "Chi Tiết Doanh Nghiêp" do
        #     #attributes_table_for 
        #   end
        # end
      end
    end
  end
#email: "user@example.com", encrypted_password: "$2a$10$SKFoGJTCaYMZfimNUVXf.u4.ug8cFLcCHgQMYjdfjTjT...", 
#reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 2, 
#current_sign_in_at: "2013-08-20 02:41:27", last_sign_in_at: "2013-08-20 02:40:47", current_sign_in_ip: "127.0.0.1", 
#last_sign_in_ip: "127.0.0.1", created_at: "2013-08-19 09:11:43", updated_at: "2013-08-20 02:41:27">
  filter :email
  #filter :role
  #filter :password

  form :title => "Tạo Người Sử Dụng" do |f|                         
    f.inputs "Chi Tiết Đăng Nhập" do       
      #f.input :status, :label => "Event Status", :as => :select#, :collection => Event::EVENT_STATUSES
      
      f.input :email
      f.input :password, :type => :password               
      f.input :password_confirmation, :type => :password
      
      #if current_admin_user.has_role? :admin
        #f.object.add_role "norm"
      #f.add_role "mode"
      if current_admin_user.role == "mode"
        f.input :role, :collection => AdminUser::ROLE_MODE, :include_blank => false,  :label => "Chức vụ"
      elsif current_admin_user.role == "admin"
        f.input :role, :input_html => {:value => "mode", :disabled => true}, :label =>  "Chức vụ"
        end



        #f.input :doanh_nghiep, :label => "Doanh Nghiệp"
      end

    f.actions do 
        f.action :submit, :label => "Câp Nhật"
        f.action :cancel, :label => "Bỏ qua"
    end
               
  end 


    
end                                   
