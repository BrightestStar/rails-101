class WelcomeController < ApplicationController
  def index
    flash[:notice] = "元帅，如果没有吩咐，那臣就退下了？"
    flash[:alert] = "这里是将军府，元帅有事您吩咐！"
    flash[:warning] = "我就在这里，随时恭侯大驾！"
  end
end
