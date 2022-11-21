class ExpensesController < ApplicationController
  before_action :set_expense, only: %i[show destroy]

  # GET /entities or /entities.json
  def index; end

  # GET /entities/1 or /entities/1.json
  def show; end

  # GET /entities/new
  def new
    @expense = Expense.new
    @expense.user_id = current_user.id
    @group = Group.find(params[:group_id])
  end

  # GET /entities/1/edit
  def edit; end

  # POST /entities or /entities.json
  def create
    @group = Group.find(params[:group_id])
    @expense = Expense.new(expense_params)
    @expense.group_id = @group.id
    @expense.user_id = current_user.id

    respond_to do |format|
      if @expense.save
        format.html { redirect_to group_path(@expense.group_id), notice: 'Transaction was successfully created.' }
        format.json { render :show, status: :created, location: @expense }
      else
        format.html { render :new, status: :unprocessable_expense }
        format.json { render json: @expense.errors, status: :unprocessable_expense }
      end
    end
  end

  # DELETE /entities/1 or /entities/1.json
  def destroy
    @expense.destroy

    respond_to do |format|
      format.html { redirect_to group_url, notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_expense
    @expense = Expense.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def expense_params
    params.require(:expense).permit(:name, :amount)
  end
end
