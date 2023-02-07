class AccountsController < ApplicationController
	# before_action :authentication
	# before_action :current_user
	# before_action :authorized
	# skip_before_action :authorized, only: [:create]x
	def new
		byebug
		@account = Account.new
		@user = User.find(params[:user_id])
		if login? && current_user == @user
			render json: @account, status: 201
		else
			render json: {account: @user.errors_full_messages}, status: 503
		end
	end


	def create
		byebug
		@user = User.find(params[:user_id])
		@account = @user.accounts.create(account_params)
		if @account.save
			render json: @account, status: 201
		else
			render json: {erors: @account.errors_full_messages}, status: 503
		end
	end

	def index
		byebug
		@user = User.find(params[:user_id])
		@accounts = @user.accounts
		if login? && current_user == @user
			render json: @accounts, status: 201
		else
			render json: {erors: @accounts.errors_full_messages}, status: 503
		end
	end

	def destroy
		byebug
		@account = Account.find(params[:id])
		@user = User.find(params[:user_id])
		if @account.delete
			render json: @account
		end
	end

	def show
		byebug
		@account = Account.find(params[:id])
		@user = @account.user
		@transactions = @account.transactions
		@transaction = @user.transactions.build
		if login? && current_user == @user
			render json: @account, status: 201
		else
			render json: {erors: @transaction.errors_full_messages}, status: 503
		end
	end
	private
	def account_params
		params.require(:account).permit(:type_of_account, :balance, :user_id)
	end
end



