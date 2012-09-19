class UsersController < ApplicationController
 # GET /
 # default index page for the application
  def index
    #show html
    @user = User.new
  end

 # GET /users/login
  def login
    user_data = params[:user]
    @user = User.where(:name => user_data[:name]).first
    if(@user.check_password?(user_data[:password]))
       redirect_to "/card_sets/" + @user.id.to_s
    else
      #redirect_to :back
    end
  end

end