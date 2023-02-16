class ApplicationController < ActionController::Base
	protect_from_forgery unless: -> { request.format.json? }
	SECRET = "yoursecretword"
	# require 'fcm'
	def send_push_notification
      byebug
      if push_notificable.activated && push_notificable.device_id &&
        push_notificable.privacy_setting["#{notify_type}".to_sym]
        fcm_client = FCM.new(ENV['FCM_SEVER_KEY']) # set your FCM_SERVER_KEY
        options = { priority: 'high',
                    data: {
                      message: remarks,
                      notify_type: "#{notify_type}",
                      account_id: account_id
                    },
                    notification: {
                    body: remarks,
                    sound: 'default'
                    }
                  }
        registration_id = push_notificable.device_id
        # A registration ID looks something like:
        #“dAlDYuaPXes:APA91bFEipxfcckxglzRo8N1SmQHqC6g8SWFATWBN9orkwgvTM57kmlFOUYZAmZKb4XGGOOL
        #9wqeYsZHvG7GEgAopVfVupk_gQ2X5Q4Dmf0Cn77nAT6AEJ5jiAQJgJ_LTpC1s64wYBvC”
        fcm_client.send(registration_id, options)
      end
    rescue Exception => e
    end

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
		token = JWT.encode payload, SECRET, "HS256"
		return token
	end

	def decode_user_data(token)
		begin
			@data = JWT.decode token, SECRET, true, { algorithm: "HS256" }
			return @data
		rescue => e
			puts e
		end
	end

	def current_user
		byebug
		@current_user ||= User.find_by(id: params["id"])
	end
end

