#ENCODING: utf-8

#admins
u = User.new :password => "miaumiau", :nick => "Quallenmann", :email => "max@mustermann.de", :password_confirmation => "miaumiau", :isAdmin => true
f = Fish.new :name => "Mrs. Gisela", :lvl => 20, :race => 14
f.save
u.fish_id = f.id
u.isAdmin = true
u.save


u = User.new :nick => "zeyorama", :email => "sponge@bob.de", :password => "zeyoramaadmin", :password_confirmation => "zeyoramaadmin", :isAdminb => true
f = Fish.new :name => "St. Peter", :lvl => 20, :race => 2
f.save
u.fish_id = f.id
u.isAdmin = true
u.save

#skills
Skill.create :name => "Dornen", 				:race => 0, :lvl => 5, :beschreibung => "Der Gegner wird verletzt, wenn er dich trifft.", :when => "hited"
Skill.create :name => "Gift", 					:race => 0, :lvl => 30, :beschreibung => "Attacke: Vermindernder Angriff, der den Gegner vergiftet", :when => "att"
Skill.create :name => "Flossenhieb", 			:race => 0, :lvl => 35, :beschreibung => "Attacke: Schlägt mit der Flosse, chance den Gegner auszusetzen", :when => "att"
Skill.create :name => "Aufgeladen", 			:race => 0, :lvl => 60, :beschreibung => "Der Gegner wird geschockt, wenn er dich trifft", :when => "hited"
Skill.create :name => "Vergeltung", 			:race => 1, :lvl => 35, :beschreibung => "Schlägt mehrmals mit verminderter Angriffskraft auf den Gegner ein", :when => "att"
Skill.create :name => "Wunden lecken", 			:race => 1, :lvl => 45, :beschreibung => "Leckt die wunden und heilt sich um einen gewissen %Anteil", :when => "att"
Skill.create :name => "Starke Verteidigung", 	:race => 2, :lvl => 5, :beschreibung => "Erhöht den Verteidigungswert stark", :when => "stat"
Skill.create :name => "Täuschung", 				:race => 2, :lvl => 15, :beschreibung => "Erschafft 3 Ebenbilder die der Gegner angreifen kann", :when => "att"
Skill.create :name => "Vergeltung", 			:race => 2, :lvl => 35, :beschreibung => "Schlägt mehrmals mit verminderter Angriffskraft auf den Gegner ein", :when => "att"
Skill.create :name => "Dehnbarkeit", 			:race => 2, :lvl => 50, :beschreibung => "Reduziert den erhaltenen Schaden", :when => "hited"
Skill.create :name => "Aufspießen", 			:race => 2, :lvl => 60, :beschreibung => "Starke Attacke die den Gegner Bluten lässt", :when => "att"
Skill.create :name => "Erhöhte Geschicklichkeit", 	:race => 3, :lvl => 20, :beschreibung => "Erhöht die Ausweichchance", :when => "stat"
Skill.create :name => "Biss", 					:race => 3, :lvl => 25, :beschreibung => "Attacke: Beißt den Gegner", :when => "att"
Skill.create :name => "Konter", 				:race => 3, :lvl => 30, :beschreibung => "Chance bei einer Attacke den Gegner anzugreifen", :when => "hited"
Skill.create :name => "Flossenhieb", 			:race => 3, :lvl => 35, :beschreibung => "Attacke: Schlägt mit der Flosse, chance den Gegner auszusetzen", :when => "att"
Skill.create :name => "Vergeltung", 			:race => 3, :lvl => 35, :beschreibung => "Schlägt mehrmals mit verminderter Angriffskraft auf den Gegner ein", :when => "att"
Skill.create :name => "Meucheln", 				:race => 3, :lvl => 45, :beschreibung => "Attacke: Trifft den Gegner Stark erst ab 50% hp anwendbar", :when => "att"
Skill.create :name => "Aufspießen", 			:race => 3, :lvl => 60, :beschreibung => "Starke Attacke die den Gegner Bluten lässt", :when => "att"
Skill.create :name => "Täuschung", 				:race => 4, :lvl => 15, :beschreibung => "Erschafft 3 Ebenbilder die der Gegner angreifen kann", :when => "att"
Skill.create :name => "Erhöhte Geschicklichkeit", 	:race => 4, :lvl => 20, :beschreibung => "Erhöht die Ausweichchance", :when => "stat"
Skill.create :name => "Biss", 					:race => 4, :lvl => 25, :beschreibung => "Attacke: Beißt den Gegner", :when => "att"
Skill.create :name => "Konter", 				:race => 4, :lvl => 30, :beschreibung => "Chance bei einer Attacke den Gegner anzugreifen", :when => "hited"
Skill.create :name => "Flossenhieb", 			:race => 4, :lvl => 35, :beschreibung => "Attacke: Schlägt mit der Flosse, chance den Gegner auszusetzen", :when => "att"
Skill.create :name => "Erhöhte Stärke", 		:race => 4, :lvl => 40, :beschreibung => "Erhöht die Stärke", :when => "stat"
Skill.create :name => "Meucheln", 				:race => 4, :lvl => 45, :beschreibung => "Attacke: Trifft den Gegner Stark erst ab 50% hp anwendbar", :when => "att"
Skill.create :name => "Erhöhte Initiative", :race => 4, :lvl => 55, :beschreibung => "Erhöht die Geschicklichkeit", :when => "stat"
Skill.create :name => "Zerfleischen", 			:race => 4, :lvl => 60, :beschreibung => "Zerfleischt den Gegner und löst bluten aus", :when => "att"
Skill.create :name => "Täuschung", 				:race => 5, :lvl => 15, :beschreibung => "Erschafft 3 Ebenbilder die der Gegner angreifen kann", :when => "att"
Skill.create :name => "Vergeltung", 			:race => 5, :lvl => 35, :beschreibung => "Schlägt mehrmals mit verminderter Angriffskraft auf den Gegner ein", :when => "att"
Skill.create :name => "Wunden lecken", 			:race => 5, :lvl => 45, :beschreibung => "Leckt die wunden und heilt sich um einen gewissen %Anteil", :when => "att"
Skill.create :name => "Dehnbarkeit", 			:race => 5, :lvl => 50, :beschreibung => "Reduziert den erhaltenen Schaden", :when => "hited"
Skill.create :name => "Starke Verteidigung", 	:race => 6, :lvl => 5, :beschreibung => "Erhöht den Verteidigungswert stark", :when => "stat"
Skill.create :name => "Schnapper", 				:race => 6, :lvl => 35, :beschreibung => "Schnappt nach dem Feind und kann ihn für die nächste runde bewegungslos machen", :when => "att"
Skill.create :name => "Erhöhte Stärke", 		:race => 6, :lvl => 40, :beschreibung => "Erhöht die Stärke", :when => "stat"
Skill.create :name => "Wunden lecken", 			:race => 6, :lvl => 45, :beschreibung => "Leckt die wunden und heilt sich um einen gewissen %Anteil", :when => "att"
Skill.create :name => "Schlecken", 				:race => 7, :lvl => 10, :beschreibung => "Schleckt den Gegner ab, chance zu verwirren", :when => "att"
Skill.create :name => "Erhärten", 				:race => 7, :lvl => 15, :beschreibung => "Erhärtet seine Haut für die nächsten 3 runden, die zusätzlich schaden absorbieren", :when => "att"
Skill.create :name => "Gift", 					:race => 7, :lvl => 30, :beschreibung => "Attacke: Vermindernder Angriff, der den Gegner vergiftet", :when => "att"
Skill.create :name => "Täuschung", 				:race => 8, :lvl => 15, :beschreibung => "Erschafft 3 Ebenbilder die der Gegner angreifen kann", :when => "att"
Skill.create :name => "Erhöhte Geschicklichkeit", 	:race => 8, :lvl => 20, :beschreibung => "Erhöht die Ausweichchance", :when => "stat"
Skill.create :name => "Konter", 				:race => 8, :lvl => 30, :beschreibung => "Chance bei einer Attacke den Gegner anzugreifen", :when => "hited"
Skill.create :name => "Meucheln", 				:race => 8, :lvl => 45, :beschreibung => "Attacke: Trifft den Gegner Stark erst ab 50% hp anwendbar", :when => "att"
Skill.create :name => "Erhöhte Initiative", :race => 8, :lvl => 55, :beschreibung => "Erhöht die Geschicklichkeit", :when => "stat"
Skill.create :name => "Erhöhte Konstitution", 	:race => 9, :lvl => 10, :beschreibung => "Erhöht die Konstitution", :when => "stat"
Skill.create :name => "Flossenhieb", 			:race => 9, :lvl => 35, :beschreibung => "Attacke: Schlägt mit der Flosse, chance den Gegner auszusetzen", :when => "att"
Skill.create :name => "Erhöhte Stärke", 		:race => 9, :lvl => 40, :beschreibung => "Erhöht die Stärke", :when => "stat"
Skill.create :name => "Zermalmen", 				:race => 9, :lvl => 60, :beschreibung => "Attacke: Zermalmt den Gegner", :when => "att"
Skill.create :name => "Erhärten", 				:race => 10, :lvl => 15, :beschreibung => "Erhärtet seine Haut für die nächsten 3 runden, die zusätzlich schaden absorbieren", :when => "att"
Skill.create :name => "Schnapper", 				:race => 10, :lvl => 35, :beschreibung => "Schnappt nach dem Feind und kann ihn für die nächste runde bewegungslos machen", :when => "att"
Skill.create :name => "Erhöhte Stärke", 		:race => 10, :lvl => 40, :beschreibung => "Erhöht die Stärke", :when => "stat"
Skill.create :name => "Zermalmen", 				:race => 10, :lvl => 60, :beschreibung => "Attacke: Zermalmt den Gegner", :when => "att"
Skill.create :name => "Starke Verteidigung", 	:race => 11, :lvl => 5, :beschreibung => "Erhöht den Verteidigungswert stark", :when => "stat"
Skill.create :name => "Schlecken", 				:race => 11, :lvl => 10, :beschreibung => "Schleckt den Gegner ab, chance zu verwirren", :when => "att"
Skill.create :name => "Schnapper", 				:race => 11, :lvl => 35, :beschreibung => "Schnappt nach dem Feind und kann ihn für die nächste runde bewegungslos machen", :when => "att"
Skill.create :name => "Wunden lecken", 			:race => 11, :lvl => 45, :beschreibung => "Leckt die wunden und heilt sich um einen gewissen %Anteil", :when => "att"
Skill.create :name => "Erhöhte Konstitution", 	:race => 12, :lvl => 10, :beschreibung => "Erhöht die Konstitution", :when => "stat"
Skill.create :name => "Täuschung", 				:race => 12, :lvl => 15, :beschreibung => "Erschafft 3 Ebenbilder die der Gegner angreifen kann", :when => "att"
Skill.create :name => "Blenden", 				:race => 12, :lvl => 25, :beschreibung => "Blendet den Gegner", :when => "att"
Skill.create :name => "Täuschung", 				:race => 13, :lvl => 15, :beschreibung => "Erschafft 3 Ebenbilder die der Gegner angreifen kann", :when => "att"
Skill.create :name => "Erhöhte Geschicklichkeit", 	:race => 13, :lvl => 20, :beschreibung => "Erhöht die Ausweichchance", :when => "stat"
Skill.create :name => "Flossenhieb", 			:race => 13, :lvl => 35, :beschreibung => "Attacke: Schlägt mit der Flosse, chance den Gegner auszusetzen", :when => "att"
Skill.create :name => "Erhöhte Initiative", :race => 13, :lvl => 55, :beschreibung => "Erhöht die Geschicklichkeit", :when => "stat"
Skill.create :name => "Dornen", 				:race => 14, :lvl => 5, :beschreibung => "Der Gegner wird verletzt, wenn er dich trifft.", :when => "hited"
Skill.create :name => "Erhöhte Geschicklichkeit", 	:race => 14, :lvl => 20, :beschreibung => "Erhöht die Ausweichchance", :when => "stat"
Skill.create :name => "Vergeltung", 			:race => 14, :lvl => 35, :beschreibung => "Schlägt mehrmals mit verminderter Angriffskraft auf den Gegner ein", :when => "att"
Skill.create :name => "Dehnbarkeit", 			:race => 14, :lvl => 50, :beschreibung => "Reduziert den erhaltenen Schaden", :when => "hited"
Skill.create :name => "Aufgeladen", 			:race => 14, :lvl => 60, :beschreibung => "Der Gegner wird geschockt, wenn er dich trifft", :when => "hited"
Skill.create :name => "Blitz", 					:race => 14, :lvl => 60, :beschreibung => "Blitz den Gegner chance zu paralysieren", :when => "att"
Skill.create :name => "Erhöhte Geschicklichkeit", 	:race => 15, :lvl => 20, :beschreibung => "Erhöht die Ausweichchance", :when => "stat"
Skill.create :name => "Biss", 					:race => 15, :lvl => 25, :beschreibung => "Attacke: Beißt den Gegner", :when => "att"
Skill.create :name => "Konter", 				:race => 15, :lvl => 30, :beschreibung => "Chance bei einer Attacke den Gegner anzugreifen", :when => "hited"
Skill.create :name => "Flossenhieb", 			:race => 15, :lvl => 35, :beschreibung => "Attacke: Schlägt mit der Flosse, chance den Gegner auszusetzen", :when => "att"
Skill.create :name => "Erhöhte Stärke", 		:race => 15, :lvl => 40, :beschreibung => "Erhöht die Stärke", :when => "stat"
Skill.create :name => "Meucheln", 				:race => 15, :lvl => 45, :beschreibung => "Attacke: Trifft den Gegner Stark erst ab 50% hp anwendbar", :when => "att"
Skill.create :name => "Zerfleischen", 			:race => 15, :lvl => 60, :beschreibung => "Zerfleischt den Gegner löst bluten aus", :when => "att"
