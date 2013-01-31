class UsersController < ApplicationController
 # GET /
 # default index page for the application
 def index
   user_id = session[:user_id]
    if(user_id)
      user = User.find(user_id)
      if(user.is_admin)
        @users = User.all
  
        respond_to do |format|
          format.html # index.html.erb
          format.json { render :json => @cards }
        end
      else
          redirect_to "/card_sets/current_user"
      end
    else
      redirect_to "/users/login"
    end
 end
 
 # Get /users/login
  def login
    
    @user = User.new
  end

 # POST /users/login_submit
  def login_submit
    user_data = params[:user]
    @user = User.where(:name => user_data[:name]).first
    if @user && @user.authenticate(user_data[:password])
      session[:user_id] = @user.id
      redirect_to "/card_sets/current_user", :notice => "Logged in!"
    else
      redirect_to "/login", :alert => "Invalid email or password"
    end
  end
  
   # POST /users/logout
  def logout
    reset_session
    redirect_to "/users/login"
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
    current_user = User.find(user_id)
    if(current_user.is_admin && params[:id])
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  end
  
  # PUT /users
  def update
    user_data = params[:user]
    user_id = session[:user_id]
    respond_to do |format|
      user = User.find(user_id)
      if(user.is_admin && params[:id])
        edited_user = User.find(params[:id])
        if(edited_user.update_attributes(user_data))
          format.html { redirect_to "/users", :notice => 'Profile was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render :action => "edit" }
          format.json { render :json => @user.errors, :status => :unprocessable_entity }
        end   
      else
        user_data.is_admin = false
        if(user.update_attributes(user_data))
          format.html { redirect_to "/card_sets/current_user", :notice => 'Profile was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render :action => "edit" }
          format.json { render :json => @user.errors, :status => :unprocessable_entity }
        end
      end
        
    end
  end
  
  # DELETE /cards/1
  # DELETE /cards/1.json
  def destroy
    user_id = session[:user_id]
    user = User.find(user_id)
    user_to_delete = User.find(params[:id])
    if(user.is_admin)
      user_to_delete.destroy
      respond_to do |format|
        format.html { redirect_to users_url }
        format.json { head :no_content }
      end
    else
      redirect_to "/card_sets/current_user", :alert => "You may not delete any users!"
    end
  end

  
end