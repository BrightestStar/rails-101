class GroupsController < ApplicationController

  before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy]
  before_action :find_group_and_check_permission, only: [:edit, :update, :destroy]
  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def show
    @group = Group.find(params[:id])
    @posts = @group.posts.order("created_at DESC")
  end



  def edit
  end

  def create
    @group = Group.new(group_params)
    @group.user = current_user

    if @group.save
      flash[:warning] ="你咋这么牛x呢！"
      redirect_to groups_path
    else
      render :new
    end
  end

  def update
    if @group.update(group_params)
      redirect_to groups_path, notice: "又做了一个牛X的事！也没谁了！"
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_path, alert: "乱扔垃圾可不好！"
  end

  private

  def find_group_and_check_permission

    @group = Group.find(params[:id])

    if current_user != @group.user
      redirect_to root_path, alert: "这是谁的地盘你不知道吗？看清楚再进入来."
    end
  end

  def group_params
    params.require(:group).permit(:title, :description)
  end

end
