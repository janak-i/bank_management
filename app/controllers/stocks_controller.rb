class StocksController < ApplicationController
	before_action :current_user
	def index
		byebug
		@stocks = Stock.all
		@user = User.find(params[:user_id])
		render json: @stocks, status: 201
	end

	def create
		@user = User.find(params[:user_id])
		@stock = Stock.new(stokes_params)
		if @stocks.save
			render json: @stocks, status: 201
		else
			render json: {erors: @stock.errors_full_messages}, status: 503
		end
	end

	def edit
	end



	def destroy
	end


	private
	def stokes_params
		params.require(:Stock).permit(:company_name, :shares_available, :price)
	end
end

