class StaticPagesController < ApplicationController
  def home
  	if signed_in?
  		@user = current_user
  		@linestudies = @user.linestudies.paginate(page: params[:page], per_page: 8)
  		@linestudy = @user.linestudies.build
  	end
  end

  def about
  end

  def help
  end

  def contact
  end
end
