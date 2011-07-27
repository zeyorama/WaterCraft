class RegistrationsController < Devise::RegistrationsController
  
    def destroy
    	f = Fish.find current_user.fish_id
    	fs = FishSkill.where :fish_id => f.id
    	
    	fs.each do |fischskill|
    		fischskill.destroy    	
    	end
    	
    	f.destroy
    	unless current_user.file.nil?
    		File.delete("public/#{current_user.image}")
    	end
  		resource.destroy
		set_flash_message :notice, :destroyed
		sign_out_and_redirect(resource)
  	end
  	
  protected

	def after_sign_up_path_for(resource)
		
    	"/profile/show/#{current_user.id}"
 	end

end
