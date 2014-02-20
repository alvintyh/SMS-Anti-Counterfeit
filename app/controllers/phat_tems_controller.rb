class PhatTemsController < ApplicationController
	def index 
		@phat_tems = PhatTem.search(params[:search])
	end

end
