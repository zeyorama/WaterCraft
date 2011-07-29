class MessagesController < ApplicationController

	
  def index
  	@m = Message.find  :all, :conditions => {:to_id => current_user.id}
  end

  def show
    begin
    	@m = Message.find params[:id]
    rescue Exception => e
    	redirect_to "/messages"
    end
  end

  def new
  	@m = Message.new
  end
  
  def destroy
    begin
    	@m = Message.find params[:id]
    	@m.destroy
    
    	redirect_to "/messages"
    rescue Exception => e
    	redirect_to "/messages"
    end
  end
  
  def create
    @m = Message.new params[:message]
    u = User.find :all, :conditions => {:nick => @m.to_name}
    unless u.first.nil?
      @m.to_id = u.first.id
      @m.from_id = current_user.id
    
      if @m.save
        redirect_to "/messages"
      else
        render action: "new"
      end
    else
      render action: "new"
    end
  end
  
  def edit
    begin
    	@m1 = Message.find params[:id]
    	@m = Message.new :to_name => (User.find @m1.from_id).nick, :body => @m1.body, :betreff => "Re: #{@m1.betreff}"
    rescue Exception => e
    	redirect_to "/messages"
    end
  end

end
