#ENCODING: utf-8
module FightHelper

end

class Creature
attr_accessor :blut, :gift, :turn, :fish, :para, :hp, :reduce, :anzahl, :hart, :wuerg
	
	def initialize fish
	  	@fish 	= fish
	  	@dev	= fish.dev
	  	@str	= fish.str
	  	@dex	= fish.dex
	  	@con	= fish.con
	  	@init	= fish.init
		@blut   = 0
		@gift   = 0
		@anzahl = 0
		@para  	= 0
		@stun 	= 0
		@hart   = 0
		@turn	= false
		@reduce = 1
		@hp		= 2 * @fish.lvl + 2 * @con + @str + @dex
		@fs		= FishSkill.where("points > 0").where(:fish_id => @fish.id)
  		
	  	#f_id = @fish.id
	  	i = 0
	  	@fs.each do |fs|
	  		tmp = getSkillsInit fs.skill_id
	  		unless tmp.first.nil?
	  			if tmp.first.name == "Starke Verteidigung"
	  				@dev += Math.sqrt(fs.points).to_i
	  			elsif tmp.first.name == "Erhöhte Stärke"
	  				@str += Math.sqrt(fs.points).to_i
	  			elsif tmp.first.name == "Erhöhte Geschicklichkeit"
	  				@dex += Math.sqrt(fs.points).to_i
	  			elsif tmp.first.name == "Erhöhte Initiative"
	  				@init += Math.sqrt(fs.points).to_i
	  			elsif tmp.first.name == "Erhöhte Konstitution"
	  				@con += Math.sqrt(fs.points).to_i
	  			end
			 end
			 i += 1
	  	end
	  	
		@fs.each do |s|
			tmp = Skill.where :id => s.skill_id, :when => "hited"
			unless tmp.first.nil?
				if tmp.first.name == "Dehnbarkeit"
					@reduce = s.points+1
				end
			end
		end
	end
	
	def getSkillsInit id
		return Skill.where :id => id
	end
	
	def getExp i
		@fish.exp += i.to_i
		@fish.save
	end

	def chooseBeginner def_creature
		d = fish.init - def_creature.fish.init
	
		if d >= 0
			d = rand(d+2)
			if d == 0
				@turn = false
				def_creature.turn = true
			else
				@turn = true
				def_creature.turn = false
			end
		else
			d = rand(-d+2)
			if d == 0
				@turn = true
				def_creature.turn = false
			else
				@turn = false
				def_creature.turn = true
			end
		end
	end
	
	def dodge
		return rand(20)-@dex/Math.sqrt(@dex)*2
	end
	
	def miss
		return rand(2+@init/Math.sqrt(@init))
	end
	
	def attack def_creature
		log = ""
		if @stun != 0
			@stun -= 1
			@para = 0
			return "<tr><td>#{def_creature.fish.name}</td><td> kann nicht handeln</td>"
		elsif @para != 0
			@para = 0
			return "<tr><td>#{def_creature.fish.name}</td><td> kann nicht handeln</td>"
		elsif def_creature.dodge <= 0
			return "<tr><td></td><td>ausgewichen</td><td>#{def_creature.fish.name}</td>"
		elsif miss <= 0
			return "<tr><td>#{@fish.name}</td><td> hat verfehlt</td>"
		else
			if def_creature.anzahl > 0
				if rand(def_creature.anzahl+1) == 0
					def_creature.anzahl = 0
				else
					def_creature.anzahl -= 1
					return "<tr><td>#{@fish.name}</td><td> greift den falschen an</td>"
				end
			end
			red = (def_creature.reduce + def_creature.fish.dev*2)/2
			att = @str + 1
			if def_creature.hart
				red /= 2
				def_creature.hart -= 1
			end
			tmp = self.selectAttack def_creature, att, red
			if tmp =~ /<\/td><td>(Wunden lecken)|(Täuschung)|(Konter)|(Erhärten)/
				log += tmp
			else
				log += tmp
				log += (def_creature.hitedCondition self)
			end
			return log
		end
	end
	
	def selectAttack def_creature, dmg, red
		dmg = dmg / 4
		
		log = ""
		skills = [ ["Tackle",1], ["Tackle",1], ["Tackle",1] ]
		@fs.each do |s|
			tmp = getSkill s
			unless tmp.first.nil?
				if tmp.first.name == "Meucheln"
					if def_creature.hp <= def_creature.fish.hp/2
						skills += [ ["#{tmp.first.name}", "#{s.points}"] ]
					end
				else
					skills += [ ["#{tmp.first.name}", "#{s.points}"] ]
				end
			end
		end
		att = skills[rand(skills.size)]
		if att[0] == "Tackle"
			dmg = dmg -red
			if dmg <= 0
				dmg = 1
			end
			def_creature.hp -= dmg
			log += "<tr><td>#{@fish.name}</td><td>#{att[0]}</td><td>#{def_creature.fish.name}</td><td>-#{dmg} HP</td><td>#{red} Wiederstanden</td>"
		elsif att[0] == "Blitz"
			dmg = dmg + Math.sqrt(att[1].to_i).to_i
			if rand(5) == 0
				def_creature.para = Math.sqrt(att[1].to_i).to_i
			end
			def_creature.hp -= dmg
			log += "<tr><td>#{@fish.name}</td><td>#{att[0]}</td><td>#{def_creature.fish.name}</td><td>-#{dmg} HP</td><td>#{red} Wiederstanden</td>"
		elsif att[0] == "Vergeltung"
			dmg = dmg - red - 5 + Math.sqrt(att[1].to_i).to_i
			if dmg <= 0 
				dmg = 1
			end
			def_creature.hp -= dmg*3
			
			
			log += "<tr><td>#{@fish.name}</td><td>#{att[0]}</td><td>#{def_creature.fish.name}</td><td>-#{dmg} HP</td><td>#{red} Wiederstanden</td>"
			log += "<td>#{@fish.name}(#{@hp})</td><td>#{def_creature.fish.name}(#{def_creature.hp})</td></tr>"
			log += "<tr><td>#{@fish.name}</td><td>#{att[0]}</td><td>#{def_creature.fish.name}</td><td>-#{dmg} HP</td><td>#{red} Wiederstanden</td>"
  			log += "<td>#{@fish.name}(#{@hp})</td><td>#{def_creature.fish.name}(#{def_creature.hp})</td></tr>"
			log += "<tr><td>#{@fish.name}</td><td>#{att[0]}</td><td>#{def_creature.fish.name}</td><td>-#{dmg} HP</td><td>#{red} Wiederstanden</td>"
		elsif att[0] == "Gift"
			dmg = (dmg - red)/3
			if dmg <= 0 
				dmg = 1
			end
			def_creature.hp -= dmg
			def_creature.gift = Math.sqrt(att[1].to_i).to_i
			log += "<tr><td>#{@fish.name}</td><td>#{att[0]}</td><td>#{def_creature.fish.name}</td><td>-#{dmg} HP</td><td>#{red} Wiederstanden</td>"
		elsif att[0] == "Flossenhieb"
			dmg = dmg - red + Math.sqrt(att[1].to_i).to_i
			if dmg <= 0 
				dmg = 1
			end
			def_creature.hp -= dmg
			if rand(5) == 0
				def_creature.para = Math.sqrt(att[1].to_i).to_i
			end
			log += "<tr><td>#{@fish.name}</td><td>#{att[0]}</td><td>#{def_creature.fish.name}</td><td>-#{dmg} HP</td><td>#{red} Wiederstanden</td>"
		elsif att[0] == "Wunden lecken"
			@hp += @fish.hp/(10-Math.sqrt(att[1].to_i).to_i)
			@blut = 0
			@gift = 0
			log += "<tr><td>#{@fish.name}</td><td>#{att[0]}</td><td></td><td>+#{@fish.hp/4} HP</td>"
		elsif att[0] == "Täuschung"
			@anzahl = Math.sqrt(att[1].to_i).to_i
			log += "<tr><td>#{@fish.name}</td><td>#{att[0]}</td><td></td><td>#{Math.sqrt(att[1].to_i).to_i} Ebenbild</td><td></td>"
		elsif att[0] == "Biss"
			dmg = dmg - red + Math.sqrt(att[1].to_i).to_i
			if dmg <= 0 
				dmg = 1
			end
			def_creature.hp -= dmg
			log += "<tr><td>#{@fish.name}</td><td>#{att[0]}</td><td>#{def_creature.fish.name}</td><td>-#{dmg} HP</td><td>#{red} Wiederstanden</td>"
		elsif att[0] == "Meucheln"
			dmg = dmg*(2+Math.sqrt(att[1].to_i).to_i/2)
			def_creature.hp -= dmg
			log += "<tr><td>#{@fish.name}</td><td>#{att[0]}</td><td>#{def_creature.fish.name}</td><td>-#{dmg} HP</td><td>#{red} Wiederstanden</td>"
		elsif att[0] == "Zerfleischen"
			dmg = dmg*(Math.sqrt(att[1].to_i).to_i/2)
			def_creature.hp -= dmg
			def_creature.blut = Math.sqrt(att[1].to_i).to_i
			log += "<tr><td>#{@fish.name}</td><td>#{att[0]}</td><td>#{def_creature.fish.name}</td><td>-#{dmg} HP</td><td>#{red} Wiederstanden</td>"
		elsif att[0] == "Blenden"
			dmg = dmg - red
			if dmg <= 0 
				dmg = 1
			end
			def_creature.hp -= dmg
			if rand(5) == 0
				def_creature.stun = Math.sqrt(att[1].to_i).to_i
			end
			log += "<tr><td>#{@fish.name}</td><td>#{att[0]}</td><td>#{def_creature.fish.name}</td><td>-#{dmg} HP</td><td>#{red} Wiederstanden</td>"
		elsif att[0] == "Schnapper"
			dmg = dmg - red + 2 + Math.sqrt(att[1].to_i).to_i
			if dmg <= 0 
				dmg = 1
			end
			def_creature.hp -= dmg
			if rand(5) == 0
				def_creature.para = Math.sqrt(att[1].to_i).to_i
			end
			log += "<tr><td>#{@fish.name}</td><td>#{att[0]}</td><td>#{def_creature.fish.name}</td><td>-#{dmg} HP</td><td>#{red} Wiederstanden</td>"
		elsif att[0] == "Schlecken"
			dmg = dmg - red + 1 + Math.sqrt(att[1].to_i.to_i).to_i
			if dmg <= 0 
				dmg = 1
			end
			def_creature.hp -= dmg
			if rand(5) == 0
				def_creature.para = Math.sqrt(att[1].to_i.to_i).to_i
			end
			log += "<tr><td>#{@fish.name}</td><td>#{att[0]}</td><td>#{def_creature.fish.name}</td><td>-#{dmg} HP</td><td>#{red} Wiederstanden</td>"
		elsif att[0] == "Erhärten"
			@hart = Math.sqrt(att[1].to_i).to_i
			log += "<tr><td>#{@fish.name}</td><td>#{att[0]}</td><td></td><td>#{@hart} Züge stärker</td>"
		elsif att[0] == "Zermalmen"
			dmg = dmg*2 + 5 + Math.sqrt(att[1].to_i.to_i).to_i
			def_creature.hp -= dmg
			log += "<tr><td>#{@fish.name}</td><td>#{att[0]}</td><td>#{def_creature.fish.name}</td><td>-#{dmg} HP</td><td>#{red} Wiederstanden</td>"
		elsif att[0] == "Aufspießen"
			dmg = dmg*2 - red
			if dmg <= 0 
				dmg = 1
			end
			def_creature.hp -= dmg
			def_creature.blut = Math.sqrt(att[1].to_i.to_i).to_i
			log += "<tr><td>#{@fish.name}</td><td>#{att[0]}</td><td>#{def_creature.fish.name}</td><td>-#{dmg} HP</td><td>#{red} Wiederstanden</td>"
		end
		
  		log += "<td>#{@fish.name}(#{@hp})</td><td>#{def_creature.fish.name}(#{def_creature.hp})</td></tr>"
		return log
	end
	
	def hitedCondition fish_attacker
		fs = FishSkill.where("points > 0").where(:fish_id => @fish.id)
		log = ""
		fs.each do |s|
			tmp = Skill.where :id => s.skill_id, :when => "hited"
			unless tmp.first.nil?
				if tmp.first.name == "Dornen"
					fish_attacker.hp -= Math.sqrt(s.points).to_i
					log += "<tr><td></td><td>Dornen</td><td>#{fish_attacker.fish.name}</td><td>-#{Math.sqrt(s.points).to_i} HP</td>"
				elsif tmp.first.name == "Aufgeladen"
					fish_attacker.hp -= Math.sqrt(s.points).to_i
					log += "<tr><td></td><td>Aufladung</td><td>#{fish_attacker.fish.name}</td><td>-#{Math.sqrt(s.points).to_i} HP</td>"
				elsif tmp.first.name == "Konter"
					if rand(20-Math.sqrt(s.points).to_i) == 0
						log += "<tr><td>Konter:</td></tr>"
						log += self.attack fish_attacker
					end
				end
			end
		end
		return log
	end
	
	def postCondition
		if @gift != 0
			@hp -= Math.sqrt(@gift).to_i
			return "<tr><td></td><td>Gift</td><td>#{@fish.name}</td><td>-#{@gift} HP</td>"
		end
		if @blut != 0
			@hp -= Math.sqrt(@blut).to_i
			return "<tr><td></td><td>Blutung</td><td>#{@fish.name}</td><td>-#{@blut} HP</td>"
		end
		return ""
	end
	
	def changeTurn def_creature
		if @turn
			@turn = false
			def_creature.turn = true
		else
			@turn = true
			def_creature.turn = false
		end
	end
	
	def getSkill s
		return Skill.where :id => s.skill_id, :when => "att"
	end
	
end
