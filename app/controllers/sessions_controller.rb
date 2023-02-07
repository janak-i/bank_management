class SessionsController < ApplicationController


	# before_action :authentication, only: [:login]
	# skip_before_action :authenticate_user!, only: [:index]


	def signup
		user = User.new(bank_id: params[:bank_id], first_name: params[:first_name], last_name: params[:last_name], street_address: params[:street_address],city: params[:city], state: params[:state], zip_code: params[:zip_code],age: params[:age], username: params[:username],email: params[:email], password_digest: params[:password_digest])
		if user.save
			token = encode_user_data({ user_data: user.id })
			render json: { token: token }
		else
			render json: { message: "invalid credentials" }
		end
	end

	def login
		byebug
		user = User.find_by(email: params[:email], password_digest: params[:password_digest])
		if user && user.password_digest == params[:password_digest]
			token = encode_user_data({ user_data: user.id })
			render json: { token: token }
		else
			render json: { message: "invalid credentials" }
		end
	end
end

