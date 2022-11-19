class ExpensesController < ApplicationController

  # GET /expenses or /expenses.json
  def index
    @group = current_user.groups.find(params[:group_id])
    @expenses = @group.expenses
    @total = @group.expenses.sum(:amount)
  end

  # GET /expenses/new
  def new
    @expense = Expense.new
    @current_user = current_user
    @group = Group.find(params[:group_id])
  end

  # POST /expenses or /expenses.json
  def create
    @group = Group.find(params[:group_id])
    @expense = @group.expenses.create(name: expense_params[:name], amount: expense_params[:amount], 
      user_id: current_user.id, group_id: @group.id)

    respond_to do |format|
      if @expense.save
        format.html do
          redirect_to user_group_expenses_path(current_user, params[:group_id]), 
          notice: 'Transaction was successfully created.'
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1 or /expenses/1.json
  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy
    @group = set_group

    respond_to do |format|
      format.html do
        redirect_to user_group_expenses_path(current_user, @group.id),
        notice: 'Budget was successfully destroyed.'
      end
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

  def set_group
    @group = Group.find(params[:group_id])
  end
end
