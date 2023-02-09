class AccountsController < ApplicationController
	# before_action :authentication
	# before_action :current_user
	# before_action :authorized
	# skip_before_action :authorized, only: [:create]x
	def new
		@account = Account.new
		@user = User.find(params[:user_id])
		if login? && current_user == @user
			render json: @account, status: 201
		else
			render json: {account: @user.errors_full_messages}, status: 503
		end
	end

	def create
		@user = User.find(params[:user_id])
		@account = @user.accounts.create(account_params)
		if @account.save
			render json: @account, status: 201
		else
			render json: {erors: @account.errors_full_messages}, status: 503
		end
	end


	def index
		@user = User.find(params[:user_id])
		@accounts = @user.accounts
		render json: @accounts, status: 201
	end

	def destroy
		@account = Account.find(params[:id])
		@user = User.find(params[:user_id])
		if @account.delete
			render json:  {message: "account successfully deleted"}
		else
			render json: {message: " soory account are not found"}
		end
	end

	def show
		@account = Account.find(params[:id])
		@user = @account.user
		render json: @account, status: 201
	end

	def withdraw
		@user=Account.find(params[:user_id])


	end

	def deposite
		@user=Account.find(params[:user_id])
	end


	private
	def account_params
		params.require(:account).permit(:type_of_account, :balance, :user_id)
	end
end



