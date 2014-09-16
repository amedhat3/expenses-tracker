class ExpensesController < ApplicationController
  before_action :set_expense, only: [:show, :edit, :update, :destroy]

  before_action :authenticate_user!
  before_action :check_owner

  respond_to :html, :json
  
  # GET /expenses
  # GET /expenses.json
  def index
    @expenses = Expense.all
    respond_with @expenses
  end

  # GET /expenses/1
  # GET /expenses/1.json
  def show
    respond_with @expense
  end

  # GET /expenses/new
  def new
    @expense = Expense.new
  end

  # POST /expenses
  # POST /expenses.json
  #api :POST, '/expenses.json'
  #param :description, :comment, :amount, :datetime
  def create
    @expense = Expense.create(expense_params)
    @expense.user_id = current_user.id
    @expense.save!
    respond_with @expense, status: 201
  end

  # PATCH/PUT /expenses/1
  # PATCH/PUT /expenses/1.json
  def update
    respond_with Expense.update(params[:id], expense_params), status: 204
  end

  # DELETE /expenses/1
  # DELETE /expenses/1.json
  def destroy
    respond_with @expense.destroy, status: 204
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense
      puts params.inspect
      @expense = Expense.find(params[:id])
    end

    def expense
      @expense ||= Expense.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def expense_params
      params.require(:expense).permit(:description, :comment, :amount, :datetime)
    end
    
    def check_owner
      permission_denied if !expense.nil? && current_user != expense.user
    end
    
    def permission_denied
      render json: {error: 'unauthorized'}, status: :unauthorized
    end
end
