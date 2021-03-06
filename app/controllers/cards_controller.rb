class CardsController < ApplicationController
  # GET /cards
  # GET /cards.json
  def index
    user_id = session[:user_id]
    if(user_id)
      user = User.find(user_id)
      if(user.is_admin)
        @cards = Card.all
  
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

  # GET /cards/1
  # GET /cards/1.json
  def show
    @card = Card.find(params[:id])
    
    user_id = session[:user_id]
    user = User.find(user_id)
    if(@card.card_set.users.include?(user) || user.is_admin)
      respond_to do |format|
        format.html # show.html.erb
        format.json { render :json => @card }
      end
    else
      redirect_to "/card_sets/current_user"
    end
    
  end

  # GET /cards/new
  # GET /cards/new.json
  def new
    @card = Card.new
    card_set = CardSet.find(params[:card_set_id])
    @card.card_set = card_set
    user_id = session[:user_id]
    @user = User.find(user_id) 

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @card }
    end
  end

  # GET /cards/1/edit
  def edit
    user_id = session[:user_id]
    @user = User.find(user_id)
    
    @card = Card.find(params[:id])
    if(!@card.card_set.users.include?(@user) && ! @user.is_admin)
      redirect_to "/card_sets/current_user"
    end
  end

  # POST /cards
  # POST /cards.json
  def create
    param_card = params[:card]
    card_set = CardSet.find(param_card[:card_set])
    param_card[:card_set] = card_set
    @card = Card.new(param_card)
    
    user_id = session[:user_id]
    user = User.find(user_id)
    

    if(@card.card_set.users.include?(user))
      respond_to do |format|
        if @card.save
          format.html { redirect_to @card, :notice => 'Card was successfully created.' }
          format.json { render :json => @card, :status => :created, :location => @card }
        else
          format.html { render :action => "new" }
          format.json { render :json => @card.errors, :status => :unprocessable_entity }
        end
      end
    else
      redirect_to "/card_sets/current_user"
    end
  end

  # PUT /cards/1
  # PUT /cards/1.json
  def update
    @card = Card.find(params[:id])
    param_card = params[:card]
    card_set = CardSet.find(param_card[:card_set])
    param_card[:card_set] = card_set

    user_id = session[:user_id]
    user = User.find(user_id)

    if(@card.card_set.users.include?(user) || user.is_admin)
      respond_to do |format|
        if @card.update_attributes(param_card)
          format.html { redirect_to @card, :notice => 'Card was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render :action => "edit" }
          format.json { render :json => @card.errors, :status => :unprocessable_entity }
        end
      end
    else
      redirect_to "/card_sets/current_user"
    end
  end

  # DELETE /cards/1
  # DELETE /cards/1.json
  def destroy
    user_id = session[:user_id]
    user = User.find(user_id)
    @card = Card.find(params[:id])
    if(@card.card_set.users.include?(user) || user.is_admin)
      @card.destroy

      respond_to do |format|
        format.html { redirect_to cards_url }
        format.json { head :no_content }
      end
    else
      redirect_to "/card_sets/current_user", :alert => "You may only delete your own cards!"
    end
  end
  
  #Study mode: Show first card for studying
  def start_study
    user_id = session[:user_id]
    user = User.find(user_id)
    card_set = CardSet.find(params[:card_set_id])
    if(card_set.users.include?(user))
      cards = Card.find(:all, :conditions =>['card_set_id = ?', params[:card_set_id]])
      card_ids = cards.collect{|card| card.id}
      cards_to_study = card_ids.sort_by{rand}
      card_id = cards_to_study.pop
      session[:cards_to_study] = cards_to_study
      redirect_to "/cards/#{card_id}/study_question"
    else
      redirect_to "/card_sets/current_user", :alert => "You may only view your own cards!"
    end
  end
  
  
  #Study mode: Show only front page with question
  def study_question
    user_id = session[:user_id]
    user = User.find(user_id)
    @card = Card.find(params[:id])
    if(@card.card_set.users.include?(user))
      respond_to do |format|
        format.html # study_question.html.erb
        format.json { render :json => @card }
      end
    else
      redirect_to "/card_sets/current_user", :alert => "You may only view your own cards!"
    end
  end
  
  #Study mode: Show only back page with answer
  def study_answer
    user_id = session[:user_id]
    user = User.find(user_id)
    @card = Card.find(params[:id])
    if(@card.card_set.users.include?(user))
      respond_to do |format|
        format.html # study_answer.html.erb
        format.json { render :json => @card }
      end
    else
      redirect_to "/card_sets/current_user", :alert => "You may only view your own cards!"
    end
  end
  
  #Study mode: Card was known
  def known
    @user = User.find(session[:user_id])
    logger.fatal("User id" + session[:user_id].to_s )
    @card = Card.find(params[:card_id])
    if(@card.card_set.users.include?(@user))
      @user.known_cards << @card
      @user.save
      next_card_id = get_next_card_to_study
      card_set_id = @card.card_set.id
      redirect_to next_card_id.nil? ? "/card_sets/current_user" :"/cards/#{next_card_id}/study_question"
    else
      redirect_to "/card_sets/current_user", :alert => "You may only mark your own cards!"
    end
  end
  
  #Study mode: Card was unknown
  def unknown
    user_id = session[:user_id]
    card_id = params[:card_id]
    @user = User.find(user_id)
    @card = Card.find(card_id)
    if(@card.card_set.users.include?(@user))
      @user.known_cards.delete(@card)
      @user.save
      next_card_id = get_next_card_to_study
      card_set_id = @card.card_set.id
      redirect_to redirect_path = next_card_id.nil? ? "/card_sets/current_user" :"/cards/#{next_card_id}/study_question"
    else
      redirect_to redirect_path = "/card_sets/current_user", :alert => "You may only mark your own cards!"
    end
  end
  
  def get_next_card_to_study
    next_index = session[:cards_to_study].pop
  end
end

