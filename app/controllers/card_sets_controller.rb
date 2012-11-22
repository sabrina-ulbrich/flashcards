class CardSetsController < ApplicationController
  # GET /card_sets
  # GET /card_sets.json
  def index
    @card_sets = CardSet.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @card_sets }
    end
  end

  # GET /card_sets/1
  # GET /card_sets/1.json
  def show
    @card_set = CardSet.find(params[:id])
    user = User.find(session[:user_id])
    if(@card_set.users.include?(user))
      respond_to do |format|
        format.html # show.html.erb
        format.json { render :json => @card_set }
      end
    else
      redirect_to card_set_current_url, :alert => 'You can only view your own card sets!'
    end  
  end

  # GET /card_sets/new
  # GET /card_sets/new.json
  def new
    @card_set = CardSet.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @card_set }
    end
  end

  # GET /card_sets/1/edit
  def edit
    @card_set = CardSet.find(params[:id])
  end

  # POST /card_sets
  # POST /card_sets.json
  def create
    @card_set = CardSet.new(params[:card_set])
    user = User.find(session[:user_id])
    @card_set.users << user

    respond_to do |format|
      if @card_set.save
        format.html { redirect_to @card_set, :notice => 'Card set was successfully created.' }
        format.json { render :json => @card_set, :status => :created, :location => @card_set }
      else
        format.html { render :action => "new" }
        format.json { render :json => @card_set.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /card_sets/1
  # PUT /card_sets/1.json
  def update
    @card_set = CardSet.find(params[:id])
    
    user = User.find(session[:user_id])
    
    if(@card_set.users.include?(user))
      respond_to do |format|
        if @card_set.update_attributes(params[:card_set])
          format.html { redirect_to @card_set, :notice => 'Card set was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render :action => "edit" }
          format.json { render :json => @card_set.errors, :status => :unprocessable_entity }
        end
      end
    else
     respond_to do |format|
        format.html { redirect_to card_set_current_url, :alert => 'You can only edit your own card sets!' }
        format.json { render :json => @card_set.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /card_sets/1
  # DELETE /card_sets/1.json
  def destroy
    @card_set = CardSet.find(params[:id])
    user = User.find(session[:user_id])
    if(@card_set.users.include?(user))
      @card_set.destroy
    end

    respond_to do |format|
      format.html { redirect_to card_set_current }
      format.json { head :no_content }
    end
  end
  
  # GET /card_sets/current_user
  def currentuser
    @user =User.find(session[:user_id])
    @card_sets = @user.card_sets
    @card_sets.each {|card_set|
      card_set.total = card_set.cards.size
      card_set.known = card_set.cards.select {|card| @user.known_cards.include?(card)}.size
      card_set.unknown = card_set.total - card_set.known
    }
    

    respond_to do |format|
      format.html # currentuser.html.erb
      format.json { render :json => @card_sets }
    end
  end

end
