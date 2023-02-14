class TransactionsController < ApplicationController
  before_action :authentication

  def new
    @account = Account.find(params[:account_id])
    @transaction = Transaction.new
    @user = @account.user
    render json: @user
  end


  def create
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
    @account = Account.find(params[:id])
    @account.delete
    render json: {message: "transaction successfully deleted"}
  end

  def credit_amount
    @account=Account.find(params[:account_id])
    @balance=@account.balance
    amount= params[:amount].to_f
    transaction_type=params[:transaction_type]
    byebug
    if transaction_type == 'credit'
      total_balance = @balance.to_f+amount.to_f
      @account.update(balance: total_balance)
    else
      render json: {erors: @total_balance.errors_full_messages}, status: 503
    end
      render json:{
      "amount": params[:amount],
      "transactiontype": transaction_type,
      "total_balance": total_balance}, status: 200
  end

  def debit_amount
    @account=Account.find(params[:account_id])
    @balance=@account.balance
    amount= params[:amount].to_f
    transaction_type=params[:transaction_type]
    if transaction_type=='debit'
      total_balance=@balance.to_f-amount.to_f
      @account.update(balance: total_balance)
    else
      render json: {erors: @total_balance.errors_full_messages}, status: 503
    end
    render json:{
      "amount": params[:amount],
      "transactiontype": transaction_type,
      "total_balance": total_balance}, status: 200
  end
  
  def total_balance_sum
    byebug
    @user=User.find(params[:user_id])
    @account=@user.accounts
    @account.balance.each do |p|
      if p=='balance'
        total_sum=p.sum(balance)
        render json: @total_sum, status: 200
      end
    end
  end



  def check_balance
    @account=Account.find(params[:account_id])
    @account.balance
    render json: @account, status: 201
  end

  private
  def transaction_params
    params.require(:transaction).permit(:type_of_transaction, :amount, :account_id, :user_id)
  end
end
