Rails.application.routes.draw do

	devise_for :users

	# atgc.work
	constraints domain: 'atgc.work' do
		get 'pages/home',	to: 'atgcpages#home'
		get 'pages/objective',	to: 'atgcpages#objective'
		get 'pages/instructions', to: 'atgcpages#instructions'
		get 'pages/data',	to: 'atgcpages#data'
		get 'pages/examples',	to: 'atgcpages#examples'
		get "Materials/:url" => "atgcpages#page_protect", :constraints => {:url => /.*/}
		root :to => 'atgcpages#index'
	end

	# rnaseq.work
	constraints domain: 'rnaseq.work' do
		get 'pages/home',	to: 'rnapages#home'
		get 'pages/objective',	to: 'rnapages#objective'
		get 'pages/instructions', to: 'rnapages#instructions'
		get 'pages/data',	to: 'rnapages#data'
		get 'pages/examples',	to: 'rnapages#examples'
		get "Materials/:url" => "rnapages#page_protect", :constraints => {:url => /.*/}
		root :to => 'rnapages#index'
	end

	# coding4medicine.com
	constraints domain: 'coding4medicine.com' do
	
		# hs.coding4medicine.com
		constraints subdomain: 'hs' do
			get 'pages/home',	to: 'hspages#home'
			get 'pages/objective',	to: 'hspages#objective'
			get 'pages/instructions', to: 'hspages#instructions'
			get 'pages/data',	to: 'hspages#data'
			get 'pages/examples',	to: 'hspages#examples'
			get "Materials/:url" => "hspages#page_protect", :constraints => {:url => /.*/}
			root :to => 'hspages#index'
		end

		get 'pages/home',	to: 'c4mpages#home'
		get 'pages/objective',	to: 'c4mpages#objective'
		get 'pages/instructions', to: 'c4mpages#instructions'
		get 'pages/data',	to: 'c4mpages#data'
		get 'pages/examples',	to: 'c4mpages#examples'
		get "Materials/:url" => "c4mpages#page_protect", :constraints => {:url => /.*/}
		root :to => 'c4mpages#index'
	end

end
