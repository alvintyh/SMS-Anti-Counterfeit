# -*- encoding : utf-8 -*-
ActiveAdmin.register_page "Dashboard" do

  menu :label => "Thông Tin Chung", :priority => 1#, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => "Thông Tin Chung" do
    #div :class => "blank_slate_container", :id => "dashboard_default_message" do
     # span :class => "blank_slate" do
     #   span I18n.t("active_admin.dashboard_welcome.welcome")
     #   small I18n.t("active_admin.dashboard_welcome.call_to_action")
     # end
    #end
    if current_admin_user.role == "norm" 
        columns do
          column do
            panel "" do
              table_for DoanhNghiep.where(:admin_user_id => current_admin_user.id).first.san_phams.order('id desc').limit(5).each do |san_pham|
                column("Tên Sản Phẩm")    {|san_pham| san_pham.name}
                column("Ngày Cấp") {|san_pham| san_pham.created_at.strftime("%d-%m-%Y %H:%M:%S")}
                column("Số Lượng") {|san_pham| san_pham.phattems.count}
                
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
                
                column("Số lần truy vấn") do |san|
                  count = 0
                  san.phattems.each do |phat|
                    if(phat.captem.package.nil?)
                      count = count + 0
                    else
                      phat.captem.package.print_managers.each do |pm|
                        count = count + pm.kh
                      end
                    end
                  end
                    
                  #string  = string + "#{c.id}\n"
                  #count = c.id + 1
                  san = count #= string
                end
              end
            end
          end
        end
         columns do
           column do
            panel "Tra Cứu Thực" do
              array = []
              sp = DoanhNghiep.where(:admin_user_id => current_admin_user.id).first.san_phams
                sp.each do |pt|
                  pt.phattems.each do |ptm|
                    ptm.captem.package.print_managers.each do |pm|
                      pm.smsdbs.each do |sms|
                        if !sms.nil?
                          array << sms
                        end
                      end
                    end
                  end  
                end
              table_for array.each do |sms|                
                column("Thời Gian")    {|s| s.updated_at.strftime("%d-%m-%Y %H:%M:%S")}
                column("Số Điện Thoại")    { |s| s.sdt }
                #column("Nội Dung Tin Nhắn")    { |s| s.message }
                column("Mã Tra Cứu") do |s|
                  if s.print_manager.nil?
                    s = "---"
                  else
                    s.print_manager.codegen_name
                  end
                end
                column("Tên Sản Phẩm") do |s|
                  s.print_manager.package.captem.phattem.san_pham.name
                end


              end
            end
          end
      end
    elsif current_admin_user.role == "mode"
         
      columns do
          column do
            panel "Doanh Nghiệp" do
              dl = DaiLy.where(:admin_user_id => current_admin_user.id).first

              table_for dl.doanh_nghieps.order('id').limit(5).each do
                column("STT") {|san_pham| san_pham.id}
                column("Tên Doanh Nghiệp") {|san_pham| san_pham.name }
                column("Địa Chỉ") {|san_pham| san_pham.dia_chi}
                column("Mã Số Thuế")    {|san_pham| san_pham.ma_so_thue }
                column("Số Điện Thoại")    {|san_pham| san_pham.dien_thoai }
                column("Số Sản Phẩm")    {|san_pham| san_pham.san_phams.count }
                
              end
            end
          end 
        end

        columns do 
          column do
            panel "Sản Phẩm" do
              array = []
              dl = DaiLy.where(:admin_user_id => current_admin_user.id).first
              dns = dl.doanh_nghieps
              dns.each do |dn|
                dn.san_phams.each do |sp|
                  array << sp
                end
              end
              table_for array do |sp|
                column("STT")    { |s| s.id }
                column("Tên Sản Phẩm")    { |s| s.name }
                column("Thuộc Doanh Nghiệp")    { |s| s.doanh_nghiep.name }
                column("Số Giấy Phép")  { |s| s.giay_phep }
                column("Nơi Cấp") { |s| s.noi_cap }
              end
            end
          end
        end
        # columns do
        #   column do
        #     panel "Quản Lý Tem" do
        #       daily = DaiLy.where(:admin_user_id => current_admin_user.id).first
        #       captem = Captem.where(:dai_ly_id => daily.id).group_by {|n| n.approve_at.beginning_of_month} 
        #         captem.sort.each do |month, tasks|
        #           tr month.strftime('%B')
                  
        #           count = 0
        #           count1 = 0
        #           count2 = 0
        #           for task in tasks
        #             if task.package.issued == 0
        #               count = count + 1
        #             end
        #             if task.issued == 1
        #               count1 = count1 + 1
        #             end
        #             if task.issued == 2
        #               count2 = count2 + 1
        #             end
        #           end

        #           tr count
        #           tr count1
        #           tr count2
        #           #tr count

        #           #tr do
        #             #th (:colspan => 2) {"Tháng"}
        #             #th (:colspan => 2) {"Tồn Đầu Kỳ"}
        #             #th (:colspan => 4) {"Nhập trong tháng"}
        #           #end
        #           # month.strftime('%B')
        #           #br
        #             #tr do
        #              # th { "Tháng" } 
        #              # td {tasks.first.approve_at}

        #             #end
        #             #br
        #             #tr do
        #             #  th { "Name" } 
        #             #  td {tasks.first.dai_ly.name}

        #             #end
        #           #end
        #       end
        #       #table_for Captem.order('id desc').group(:approve_at).each do |san_pham|
        #       ##  column("Tháng") {|san_pham| san_pham.created_at.month}
        #        # column("Tồn Đầu Kỳ") {|san_pham| san_pham.captem.issued}
        #       #  column("Nhập Trong Tháng")  {|san_pham| san_pham.captem}
        #         #column("Đã Cấp Phát") {|san_pham| san_pham.captem}
        #         #column("Tồn Cuối Kỳ") {|san_pham| san_pham.captem}

        #       #end
        #     end
        #   end

      #end
       elsif current_admin_user.role == "admin"
       columns do
          column do
            panel "Doanh Nghiệp" do
              table_for DoanhNghiep.order('id desc').limit(5).each do |san_pham|
                column("STT") {|san_pham| san_pham.id}
                column("Tên Doanh Nghiệp") {|san_pham| san_pham.name }
                column("Địa Chi") {|san_pham|san_pham.dia_chi}
                column("Mã Số Thuế"){|san_pham| san_pham.ma_so_thue}
                column("Số Điện Thoại")    {|san_pham| san_pham.dien_thoai  }

                column("Số Sản Phẩm")    {|san_pham| san_pham.san_phams.count }
                column("Đại Lý") {|san_pham| san_pham.dai_ly.name}
                
              end
            end
          end 
      end
       columns do
          column do
            panel "Tồn Kho" do
              table_for DaiLy.order('id desc').each do |san_pham|
                column("STT") {|san_pham| san_pham.id}
                column("Đại Lý")    {|san_pham| san_pham.name }
                #column("Tên Sản Phẩm") {|san_pham| san_pham.san_pham.name }
                #column("Tên Doanh Nghiệp") {|san_pham| san_pham.san_pham.doanh_nghiep.name }
                
                column("Tồn Kho")  do |row|
                  count = 0
                  row.captems.each do |ct|
                  #row.doanh_nghieps do |dn|
                    if ct.issued == 1   
                      count = count + 1
                    end
                  end
                  row = count
                end
                column("Nhập Mới Trong Tháng") do |row|
                  count = 0
                  row.dangki_captems.each do |m|
                    if m.approve == 1
                      count = count + m.luong_lo
                    end
                  end
                row = count
                end

                column("Đã Cấp Phát") do |row|
                  count = 0
                  row.captems.each do |ct|
                    if ct.issued == 2
                      count = count + 1

                    end
                  end
                  row = count

                end
                column("Tồn Cuối Kỳ") do |row|
                  count = 0
                  row.captems.each do |ct|
                  #row.doanh_nghieps do |dn|
                    if ct.issued == 1   
                      count = count + 1
                    end
                  end
                  row = count
                end

              end
            end
          end 
      end
      
      columns do
          column do
            panel "Tra Cứu Thực" do
              table_for Smsdb.order('id desc').limit(10).each do |san_pham|
                column("Thời Gian") {|san_pham| san_pham.updated_at }
                column("Số Điện Thoại") {|san_pham| san_pham.sdt}
                column("Mã Tra cứu")  do |row|
                  if (row.print_manager.nil?)
                    row = "Không Có Mã"
                  else
                    row.print_manager.codegen_name
                  end
                end

                column("Tên Sản Phẩm") do |row|
                  if row.print_manager.nil?
                    row = "---"
                  else 
                    if row.print_manager.package.captem.nil?
                      row = "Tem Chưa Cấp"
                    else
                      if row.print_manager.package.captem.phattem.nil?
                        row = "Tem Chưa Phát"
                      else
                        row.print_manager.package.captem.phattem.san_pham.name
                      end
                    end
                  end
                end
                column("Tên Doanh Nghiệp") do |row|
                  if row.print_manager.nil?
                    row = "---"
                  else 
                    if row.print_manager.package.captem.nil?
                      row = "Tem Chưa Cấp"
                    else
                      if row.print_manager.package.captem.phattem.nil?
                        row = "Tem Chưa Phát"
                      else
                        row.print_manager.package.captem.phattem.san_pham.doanh_nghiep.name
                      end
                    end
                  end
                end
                column("Tên Đai Lý") do |row|
                  if row.print_manager.nil?
                    row = "---"
                  else 
                    if row.print_manager.package.captem.nil?
                      row = "Tem Chưa Cấp"
                    else
                      if row.print_manager.package.captem.phattem.nil?
                        row = "Tem Chưa Phát"
                      else
                        row.print_manager.package.captem.phattem.san_pham.doanh_nghiep.dai_ly.name
                      end
                    end
                  end
                end
                #column("Tên Đại Lý")   {|san_pham| san_pham.name }
                column("Số Lần Tra Cứu") do |row|
                  if row.print_manager.nil?
                    row = "---"
                  else 
                    row.print_manager.kh
                  end
                end
                end
              end
            end 
          end
      end
  
  end
  #end
    #section "Your tasks for this week" do
    #    table_for DoanhNghiep.recent(3) do |t|
           # t.column("doanh_nghiep") { |doanh_nghiep| link_to invoice.name, admin_invoice_path(name) }
      
    #    end
    #  end
 
    # Here is an example of a simple dashboard with columns and panels.
    #
     #columns do
     #  column do
     #    panel "Recent Posts" do
     #      ul do
     #        PhatTem.recent(5).map do |post|
    #           li link_to(post.san_pham, admin_phat_tem_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
     
  # content
end
