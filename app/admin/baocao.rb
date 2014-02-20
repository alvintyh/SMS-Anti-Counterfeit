# -*- encoding : utf-8 -*-
ActiveAdmin.register_page "Baocao" do

	menu :label => "Báo Cáo",  :if => proc { current_admin_user.role == "norm" }
	content :title => "Báo Cáo" do

		#h1 current_admin_user.id.to_s
		@arrays = []
        #@date = (params[:date]).to_datetime
        #@phats = Phattem.where(date("approve_at") == @date)
        if params[:date].nil?
	        sps = DoanhNghiep.where(:admin_user_id => current_admin_user.id).first.san_phams
	            sps.each do |sp|
	                sp.phattems.each do |pt|
	                    pt.captem.package.print_managers.each do |pm|
	                      	pm.smsdbs.each do |sms|
	                        	if !sms.nil?
	                          		@arrays << sms
	                        	end
	                      	end
	                    end
	                end  
	            end
	    else
	    	sps = DoanhNghiep.where(:admin_user_id => current_admin_user.id).first.san_phams
	    		sps.each do |sp|
	    			sp.phattems.each do |pt|
	    				if(pt.approve_at.to_datetime == (params[:date]).to_datetime)
			    	
				    		pt.captem.package.print_managers.each do |pm|
				    					#@date = params[:date]
			    	
				    			pm.smsdbs.each do |sms|
				    				if !(sms.nil?)	
				    					@arrays << sms
				    				end
				    			end
				    		end
				    	end
		    		end
	    		end
			

	    end
       # Smsdb[] = arrays
		panel "Tra cứu" do
			table_for @arrays do |row|
				row.column("Thời Gian") {|m| m.updated_at.strftime("%Y-%m-%e %I:%M %p")}
				row.column("Số Điện Thoại") {|m| m.sdt}
				row.column("Mã Tem") {|m|	m.print_manager.codegen_name}
				row.column("Series") {|m| m.print_manager.package.name}
				row.column("Sản Phẩm") {|m| m.print_manager.package.captem.phattem.san_pham.name}
				#row.column("Hình Thức Tra Cứu") 

			end
		end

		
	end


	


  
end
