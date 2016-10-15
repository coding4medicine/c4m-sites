class C4mpagesController < ApplicationController

	before_action :authenticate_user!
	skip_before_action :authenticate_user!, :only => [:index]

	layout 'c4m', except: [:index]

	def index
		render layout: "c4mfront"
	end

	def home
	end

	def page_protect
		file_path = "#{Rails.root}/Materials/" + params[:url]
		send_file(file_path, type: 'text/html', disposition: 'inline')
	end


end
