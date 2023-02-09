class TransactionsController < ApplicationController

  def new
    byebug
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
    @transaction = Transaction.find(params[:id])
    @transaction.delete
    render json: {message: "transaction successfully deleted"}
  end

  def credit_amount
    @account=Transaction.find(params[:account_id])
    balance =params[:balance].to_f
    amount= params[:amount].to_f
    transaction_type=params[:transaction_type]
    if transaction_type == 'credit'
      total_balance = balance.to_f+amount.to_f
      @account =Transaction.new
    elsif@account.save 
    else
      render json: {erors: @total_balance.errors_full_messages}, status: 503
    end
      render json:{
      "balance": "#{balance}#{transaction_type}",
      "transactiontype": transaction_type,
      "remainbalance": total_balance}, status: 200
  end


  def debit_amount
    byebug
    @account=Transaction.find(params[:account_id])
    balance =params[:balance].to_f
    amount= params[:amount].to_f
    transaction_type=params[:transaction_type]
    if transaction_type=='debit'
      byebug
      total_balance=balance.to_f-amount.to_f
    else
      render json: {erors: @transaction.errors_full_messages}, status: 503
    end
    render json:{
      "amount": params[:amount],
      "balance": "#{balance}#{transaction_type}",
      "transactiontype": transaction_type,
      "remainbalance": total_balance}, status: 200
  end
  private
  def transaction_params
    params.require(:transaction).permit(:type_of_transaction, :amount, :account_id, :user_id)
  end
end


