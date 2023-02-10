
class SharesController < ApplicationController
	def show
		@share = Share.find(params[:id])
		render json: @share
	end

	def index
		@user = User.find(params[:user_id])
		@stocks = Stock.all
		@share = Share.new
		render json: @share, status: 201
	end

	def create
		byebug
		@user = User.find(params[:user_id])
		share = Share.new(share_params)
		share.company_name = Stock.find(share.stock_id).company_name
		@user.shares << share
		@stock = Stock.find(share.stock_id)
		byebug
		if @user.save && @stock.shares_available - share.quantity > 0
			@stock.shares_available = @stock.shares_available - share.quantity
			@stock.save
			render json: @stock, status: 201
		else
			render json: {erors: @stock}, status: 503
		end
	end

	def edit

	end

	def update
	end

	def destroy
	end

	private
	def share_params
		params.require(:share).permit(:user_id, :stock_id, :company_name, :quantity)
	end
end
