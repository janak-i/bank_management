# class UsersController < ApplicationController


#     def index
#         @users=User.all
#         render json: @users, status: 201
#     end


# 	def new
# 		@user = User.new
# 	end

#     def create
#         byebug
#         @user = User.new(user_params)
#         if @user.valid?
#             user.save
#             render json: @user, status: 201
#         else
#             render json: {erors: @user.errors_full_messages}, status: 503
#         end
#     end

#     def show
#         byebug
#         @user = User.find(params[:id])
#         if @user.valid?
#             render json: @user, status:200
#         else
#             render json: {erors: @user.errors_full_messages},status: 503
#         end
#     end

#     private
#     def user_params
#         params.require(:user).permit(:bank_id, :first_name, :last_name, :street_address, :city, :state, :zip_code, :age, :username, :email, :password)
#     end
# end


