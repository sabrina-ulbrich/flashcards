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
      redirect_to "/users", :alert => "Invalid email or password"
    end
  end
  
   # POST /users/login
  def logout
    reset_session
    redirect_to "/users"
  end
  
  # GET /cusers/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @card }
    end
  end
  
  # POST /users
  # POST /user.json
  def create  

    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to "/card_sets/current_user", :notice => "User created!" }
        format.json { render :json => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # GET /users/edit
  def edit
    user_id = session[:user_id]
    @user = User.find(user_id)
  end
  
  # PUT /users
  def update
    user_id = session[:user_id]
    respond_to do |format|
      @user = User.find(user_id)
      if(@user.update_attributes(params[:user]))
        format.html { redirect_to "/card_sets/current_user", :notice => 'Profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  
end