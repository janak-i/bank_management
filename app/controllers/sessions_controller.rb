class SessionsController < ApplicationController


	# before_action :authentication, only: [:login]
	# skip_before_action :authenticate_user!, only: [:index]
	def signup
		byebug
		user = User.new(email: params[:email], password_digest: params[:password_digest])
		if user.save
			token = encode_user_data({ user_data: user.id })
			render json: { token: token }
		else
			render json: { message: "invalid credentials" }
		end
	end


	def login
		byebug
		user = User.find_by(email: params[:email])
		if user && user.password == params[:password]
			token = encode_user_data({ user_data: user.id })
			render json: { token: token }
		else
			render json: { message: "invalid credentials" }
		end
	end
end




	