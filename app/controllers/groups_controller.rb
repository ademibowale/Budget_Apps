class GroupsController < ApplicationController
  before_action :set_group, only: %i[destroy]

  # GET /groups or /groups.json
  def index
    if user_signed_in?
      @user = current_user
      @groups = @user.groups
      @expenses = current_user.expenses
    else
      render root_path
    end
  end

  # GET /groups/new
  def new
    @user = User.find(params[:user_id])
    @group = Group.new
  end

  # POST /groups or /groups.json
  def create
    puts group_params
    @user = User.find(params[:user_id])
    @group = Group.new(group_params)
    @group.user_id = @user.id

    if @group.valid?
      @group.save
      flash[:notice] = 'New Category was successfully created.'
      redirect_to user_groups_path(@user)
    else
      flash[:alert] = 'Input a valid Icon image and Name.'
      render :new
    end
  end

  # DELETE /groups/1 or /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to user_groups_path, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_group
    @group = Group.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def group_params
    params.require(:group).permit(:name, :icon)
  end
end
