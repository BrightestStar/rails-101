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
    @posts = @group.posts.recent.paginate(:page => params[:page], :per_page => 5)
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

  def join
    @group = Group.find(params[:id])

     if !current_user.is_member_of?(@group)
       current_user.join!(@group)
       flash[:notice] = "士兵你来了，一边候着吧。"
     else
       flash[:warning] = "你认为将军是那么好当的吗？好好努力吧，士兵！"
     end

     redirect_to group_path(@group)
   end

    def quit
      @group = Group.find(params[:id])

      if current_user.is_member_of?(@group)
        current_user.quit!(@group)
        flash[:alert] = "你认为这是你家后花院吗？想来就来想走就走。"
      else
        flash[:warning] = "你不是本营士兵.再进一步杀！！！"
      end

      redirect_to group_path(@group)
    end

  private

  def find_group_and_check_permission

    @group = Group.find(params[:id])

    if current_user != @group.user
      redirect_to root_path, alert: "这是谁的地盘你不知道吗？看清楚了再进。"
    end
  end

  def group_params
    params.require(:group).permit(:title, :description)
  end

end
