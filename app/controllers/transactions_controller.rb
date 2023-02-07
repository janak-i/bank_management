class TransactionsController < ApplicationController

  def new
    @account = Account.find(params[:account_id])
    @transaction = Transaction.new
    @user = @account.user

    if logged_in? && current_user == @user
    else
      flash[:message] = "Access Denied: Invalid User"
      redirect_to '/'
    end
  end

  def create
    @account = Account.find(params[:account_id])
    @transaction = @account.transactions.build(transaction_params)

    if @transaction.save
      render json: @transaction
    else
      flash[:message] = @transaction.errors.full_messages_for(:amount).first
      render "accounts/show"
    end
  end

  def edit
    @transaction = Transaction.find(params[:id])
    @transaction.process_transaction
    redirect_to account_path(@transaction.account_id)
  end

  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.delete
    redirect_to account_path(params[:account_id])
  end

  def highest
    @highest = Transaction.highest_deposit
  end

  private

  def transaction_params
    params.require(:transaction).permit(:type_of_transaction, :amount, :account_id, :user_id)
  end
end
