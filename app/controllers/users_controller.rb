class UsersController < ApplicationController
 # GET /
 # default index page for the application
  def index
    #show html
    @user = User.new
  end

 # POST /users/login
  def login
    user_data = params[:user]
    @user = User.where(:name => user_data[:name]).first
    if @user && @user.authenticate(user_data[:password])
      session[:user_id] = @user.id
      redirect_to "/card_sets/current_user", :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
    end
  end
end