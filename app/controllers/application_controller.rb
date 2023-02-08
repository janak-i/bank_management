class ApplicationController < ActionController::Base
	protect_from_forgery unless: -> { request.format.json? }
	SECRET = "yoursecretword"

	def authentication
		decode_data = decode_user_data(request.headers["token"])
		user_data = decode_data[0]["user_data"] unless !decode_data
		user = user_data
		if user
			return true
		else
			render json: { message: "invalid credentials" }
		end
	end

	def encode_user_data(payload)
		byebug
		token = JWT.encode payload, SECRET, "HS256"
		return token
	end

	def decode_user_data(token)
		begin
			byebug
			data = JWT.decode token, SECRET, true, { algorithm: "HS256" }
			return data
		rescue => e
			puts e
		end
	end


	def current_user
      @current_user ||= User.find(@token.id) if @token.present?
    end

	# def current_user
	# 	if decode_user_data
	# 		user_id = decode_user_data[0]['user_id']
	# 		@user = User.find_by(id: user_id)
	# 	else
	# 		render json: { message: 'Did not find user.' }, status: :unauthorized
	# 	end

	# end

	# def logged_in?
	# 	byebug
	# 	!!current_user
	# end

	# def authorized
	# 	render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
	# end



	# def decode_user_data(token)
	# 	begin
	# 		JWT.decode token, SECRET, true, { algorithm: "HS256" }
	# 	rescue => e
	# 		puts e
	# 	end
	# end
end

