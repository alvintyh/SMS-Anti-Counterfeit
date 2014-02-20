# -*- encoding : utf-8 -*-
class HomeController < ApplicationController

	def index

		@message = "trung"
	end

	def dividers
	end

	def show
	end
	def search
	  	if(!params["search"].nil?)
	    	ma_tem = params["search"]["ma_tem"]
		  	sanpham = PrintManager.where(:codegen_name => ma_tem).first
		  	if (sanpham.nil?)
		  		@poke = "Mã Tem không tồn tại"
			else
			  	if (sanpham.package.captem.nil?)
			  		@poke = "Tem Chưa Cấp Cho Đại Lý"
			  	else
			  		if (sanpham.package.captem.phattem.nil?)
			  			@poke = "Tem Chưa Cấp Cho Doanh Nghiệp"
			  		else
			  			@poke = "Thông Tin San Phẩm"
		    			@result = sanpham.package.captem.phattem.san_pham
			 		end
			 	end
			end
		end
		  	
	end   
end
