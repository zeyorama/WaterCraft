#ENCODING: utf-8
class ProfileController < ApplicationController
	
  def show
  	@profil = User.find params[:id]
  	@anz = @profil.win + @profil.lose
  	f_id = @profil.fish_id
	
	unless f_id.nil?
	  	@fish = Fish.find @profil.fish_id
	  	
	  	(FishSkill.where("points > 0").where :fish_id => f_id).each do |fs|
	  		tmp = Skill.where :id => fs.skill_id, :when => "stat"
	  		unless tmp.first.nil?
	  			if tmp.first.name == "Starke Verteidigung"
	  				@fish.dev += Math.sqrt(fs.points)
	  			elsif tmp.first.name == "Erhöhte Stärke"
	  				@fish.str += Math.sqrt(fs.points)
	  			elsif tmp.first.name == "Erhöhte Geschicklichkeit"
	  				@fish.dex += Math.sqrt(fs.points)
	  			elsif tmp.first.name == "Erhöhte Konstitution"
	  				@fish.con += Math.sqrt(fs.points)
	  			end
			 end
	  	end
	end
  	
  end

  def edit
  end
  
  def create
  		current_user.fish_id = nil
  		current_user.save
  		
  		@f = Fish.all
  		@f.each do |s|
  			@u = User.where :fish_id => s.id
  			if @u.first.nil?
  				s.destroy
  			end
  		end
  		
  		@stat = getRaceStat params[:race].to_i
  		if params[:nick] == ""
  			params[:nick] = "Anonymous"
  		end
    	@f = Fish.new :race => params[:race], :name => params[:nick], :str => @stat[:str], :dex => @stat[:dex], :con => @stat[:con], :init => @stat[:init], :dev => @stat[:dev]

		if @f.save
			u = User.find current_user.id
			u.fish_id = @f.id
			u.save
		    redirect_to "/profile/show/#{current_user.id}"
		else
		    render "/profile/new"
		end
  end
  
  def new
  	
  	dirname = "app/assets/images/Fisch"
  	dir = Dir.new(dirname)
  	@entries = []
  	while entry = dir.read
  		path = "#{dirname}/#{entry}"
  		if File.file?(path)
  			@entries.push "Fisch/#{entry}"
  		end
  	end
  	
  end

  def index
  	@u = User.order('nick asc')
  end

  def delete
	if current_user.isAdmin == true
	  	user = User.find (params[:id])
		unless user.fish_id.nil?
			f = Fish.find user.fish_id
			user.fish_id = nil
			user.save
			fs = FishSkill.where :fish_id => f.id
			
			fs.each do |fischskill|
				fischskill.delete	
			end
			f.delete
		end
		
    	if user.image?
			File.delete("public/#{user.image}")
		end
		user.destroy
	 	redirect_to("/profile/index")
  	end
  end

end
