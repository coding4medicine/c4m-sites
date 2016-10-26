class RnapagesController < ApplicationController

	before_action :authenticate_user!
	skip_before_action :authenticate_user!, :only => [:index]

	layout 'rna', except: [:index]

	def index
		render layout: "rnafront"
	end

	def home
	end

	def objective
	end

	def instructions
	end

	def data
	end

	def examples
	end


	def page_protect
		file_path = "#{Rails.root}/Materials/" + params[:url]
		send_file(file_path, type: 'text/html', disposition: 'inline')
	end
end
