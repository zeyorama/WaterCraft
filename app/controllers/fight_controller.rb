class FightController < ApplicationController
  def show
  	begin
	  	unless current_user.id == params[:id].to_i || (User.find params[:id]).fish_id.nil? || current_user.fish_id.nil?
	  		@Fehler = false
		  	@attack = current_user
		  	@defense = User.find params[:id]
		  	@log = "<table id = 'fight' align=center>"
		  	
		  	@attack_creature = Creature.new ( Fish.find current_user.fish_id )
		  	@defense_creature = Creature.new ( Fish.find @defense.fish_id )
		  	@attack_creature.chooseBeginner @defense_creature
		  	
		  	@log = the_fight @attack_creature, @defense_creature, @log
		  	
		  	if @defense_creature.hp <= 0 && @attack_creature.hp <= 0
		  		@log += "<div id='erg'> Uentschieden</div><br><br>"
		  		draw @attack, @defense, @attack_creature, @defense_creature
		  	elsif @defense_creature.hp <= 0
		  		@log += "<div id='erg'>#{@attack.nick}s Fish #{@attack_creature.fish.name} gewinnt!</div><br><br>"
		  		afterFight @attack, @defense, @attack_creature, @defense_creature
		  	else
		  		@log += "<div id='erg'>#{@defense.nick}s Fisch #{@defense_creature.fish.name} gewinnt!</div><br><br>"
		  		afterFight @defense, @attack, @defense_creature, @attack_creature
		  	end
		  	
		  	@m = Message.create :from_id => 1, :to_id => @defense.id, :body => "Ihr wurdet von #{@attack.nick} angegriffen. #{@log}", :betreff => "Angriff von #{@attack.nick} am #{Time.now.strftime('%d.%m.%Y')}", :to_name => @defense.nick
	  	else
	  		@Fehler = true
	  	end
	  rescue Exception => e 
	  	@Fehler = true
	  end
  end

  def nextLvl lvl
	if lvl < 60
		exp = 0
		lvl.times do
			exp += 90
		end
		return exp
	end
	return 5400
  end
  
  def afterFight winner, loser, winner_c, loser_c
  	winner_c.getExp 10
  		if winner_c.fish.exp >= nextLvl( winner_c.fish.lvl )
  			winner_c.fish.lvl += 1
  			winner_c.fish.hp = getHP winner_c.fish.lvl, winner_c.fish.con, winner_c.fish.str, winner_c.fish.dex
  			winner_c.fish.save
  		end
  		loser.lose += 1;
  		winner.win += 1;
  		loser.save
  		winner.save
  end
  
  def draw p1, p2, p1_c, p2_c
	p1_c.getExp 5
	p2_c.getExp 5
	if p2_c.fish.exp >= nextLvl( p2_c.fish.lvl )
		p2_c.fish.lvl += 1
		p2_c.fish.hp = getHP p2_c.fish.lvl, p2_c.fish.con, p2_c.fish.str, p2_c.fish.dex
		p2_c.fish.save
	end
	if p1_c.fish.exp >= nextLvl( p1_c.fish.lvl )
		p1_c.fish.lvl += 1
		p1_c.fish.hp = getHP p1_c.fish.lvl, p1_c.fish.con, p1_c.fish.str, p1_c.fish.dex
		p1_c.fish.save
	end
	p1.lose += 1
	p2.lose += 1
	p1.save
	p2.save
  end
  
  def the_fight attack, defense, log
  	while defense.hp > 0 && attack.hp > 0 do
  		
  		if attack.turn
  			log += attack.attack defense
  			log += attack.postCondition
  			attack.changeTurn defense
  		else
  			log += defense.attack attack
  			log += defense.postCondition
  			defense.changeTurn attack
  		end
  	end
  		return log
  end

end
