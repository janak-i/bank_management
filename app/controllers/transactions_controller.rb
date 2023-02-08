 class TransactionsController < ApplicationController

  def new
    byebug
    @account = Account.find(params[:account_id])
    @transaction = Transaction.new
    @user = @account.user
    render json: @user
  end

  def create
    byebug
    @account = Account.find(params[:account_id])
    @transaction = @account.transactions.create(transaction_params)

    if @transaction.save
      render json: @transaction, status: 201
    else
      render json: {erors: @transaction.errors_full_messages}, status: 503
    end
  end

  def edit
    @transaction = Transaction.find(params[:id])
    if @transaction.process_transaction
      render json: @transaction.account_id, status: 201
    else
      render json: {erors: @transaction.errors_full_messages}, status: 503
    end
  end

  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.delete
    render json: {message: "transaction successfully deleted"}
  end

  def highest
    @highest = Transaction.highest_deposit
  end

  private

  def transaction_params
    params.require(:transaction).permit(:type_of_transaction, :amount, :account_id, :user_id)
  end
end





