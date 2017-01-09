Rails.application.routes.draw do

	resources :sshkeys
	devise_for :users, :controllers => { registrations: 'registrations' }

	# atgc.work
	constraints domain: 'atgc.work' do
		get 'pages/home',	to: 'atgcpages#home'
		get "Materials/:url" => "atgcpages#page_protect", :constraints => {:url => /.*/}
		root :to => 'atgcpages#index'
	end

	# rnaseq.work
	constraints domain: 'rnaseq.work' do
		get 'pages/home',	to: 'rnapages#home'
		get "Materials/:url" => "rnapages#page_protect", :constraints => {:url => /.*/}
		root :to => 'rnapages#index'
	end

	# coding4medicine.com
	constraints domain: 'coding4medicine.com' do
	
		# hs.coding4medicine.com
		constraints subdomain: 'hs' do
			get 'pages/home',	to: 'hspages#home'
			get "Materials/:url" => "hspages#page_protect", :constraints => {:url => /.*/}
			root :to => 'hspages#index'
		end

		get 'pages/home',	to: 'c4mpages#home'
		get "Materials/:url" => "c4mpages#page_protect", :constraints => {:url => /.*/}
		root :to => 'c4mpages#index'
	end

end
