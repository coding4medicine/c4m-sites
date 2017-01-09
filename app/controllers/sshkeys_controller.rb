class SshkeysController < ApplicationController

	before_action :set_sshkey, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!

	layout 'ssh'

	# GET /sshkeys
	def index
		@sshkeys = current_user.sshkeys.all
		@server_id=""
		File.open("#{Rails.root}/names").each do |line|
        		words=line.split(/\s+/)
        		if words[0] == current_user.email
                		@server_id=words[1]
        		end
		end
	end

	# GET /sshkeys/1
	def show
		if current_user.id != Sshkey.find(params[:id]).user_id
			redirect_to sshkeys_path
		end
	end

	# GET /sshkeys/new
	def new
		@sshkey = Sshkey.new
	end

	# GET /sshkeys/1/edit
	def edit
		if current_user.id != Sshkey.find(params[:id]).user_id
			redirect_to sshkeys_path
		end
	end

	# POST /sshkeys
	def create
		@sshkey = Sshkey.new(sshkey_params)
		@sshkey.user_id=current_user.id

		respond_to do |format|
		if @sshkey.save
			filename="keys" + rand(1000000).to_s
			f=File.open("/tmp/keys/"+filename,"w+")
			txt=current_user.email + ' ' + ' ' + Time.now.to_i.to_s + "\n"
			f.write(txt)
			txt=@sshkey.key + "\n"
			f.write(txt)
			f.close
			cmd="chmod 400 /tmp/keys/"+filename
			value=`#{cmd}`
			cmd="scp /tmp/keys/"+filename+" " +  ENV['DOMAIN0']
			value=`#{cmd}`
			cmd="scp /tmp/keys/"+filename+" " +  ENV['DOMAIN1']
			value=`#{cmd}`
			cmd="scp /tmp/keys/"+filename+" " +  ENV['DOMAIN2']
			value=`#{cmd}`
			format.html { redirect_to @sshkey, notice: 'Sshkey was successfully created.' }
		else
			format.html { render :new }
		end
		end
	end

	# PATCH/PUT /sshkeys/1
	def update
		if current_user.id != Sshkey.find(params[:id]).user_id
			redirect_to sshkeys_path
		end
		respond_to do |format|
		if @sshkey.update(sshkey_params)
			filename="keys" + rand(1000000).to_s
			f=File.open("/tmp/keys/"+filename,"w+")
			txt=current_user.email + ' ' + ' ' + Time.now.to_i.to_s + "\n"
			f.write(txt)
			txt=@sshkey.key + "\n"
			f.write(txt)
			f.close
			cmd="chmod 400 /tmp/keys/"+filename
			value=`#{cmd}`
			cmd="scp /tmp/keys/"+filename+" " +  ENV['DOMAIN0']
			value=`#{cmd}`
			cmd="scp /tmp/keys/"+filename+" " +  ENV['DOMAIN1']
			value=`#{cmd}`
			cmd="scp /tmp/keys/"+filename+" " +  ENV['DOMAIN2']
			value=`#{cmd}`
			format.html { redirect_to @sshkey, notice: 'Sshkey was successfully updated.' }
		else
			format.html { render :edit }
		end
		end
	end

	# DELETE /sshkeys/1
	def destroy
		if current_user.id != Sshkey.find(params[:id]).user_id
			redirect_to sshkeys_path
		else
			@sshkey.destroy
			respond_to do |format|
			format.html { redirect_to sshkeys_url, notice: 'Sshkey was successfully destroyed.' }
		end
		end
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_sshkey
		@sshkey = Sshkey.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def sshkey_params
		params.require(:sshkey).permit(:user_id, :key)
	end
end
