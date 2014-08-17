
class LPHue

	require 'rest-client'
	require 'json'

	
	def discover_lights
		lights_hash = JSON.parse(RestClient.get "http://#{bridge_ip}/api/newdeveloper/lights")
		
		lights = []
		lights_hash.each do |key, value|
		light_hash = [:key => key, :name => value['name'], :state => value['state']['on']]
		lights.push light_hash
		end
		
		return lights
		
	end
	
	def flip_light(light_key, light_state)
		RestClient.put "http://#{bridge_ip}/api/newdeveloper/lights/#{light_key}/state", {:on => state(light_state)}.to_json
	end

	def flip_light_with_colors(light_key, light_state, color_hash)
		RestClient.put "http://#{bridge_ip}/api/newdeveloper/lights/#{light_key}/state", {:on => state(light_state), :bri => color_hash['bri'], :sat => color_hash['sat'], :hue => color_hash['hue']}.to_json
	end

private
	
	def bridge_ip
		if !@bridge_ip
			discover_local_bridge_ip
		end
		return @bridge_ip
	end
	
	def discover_local_bridge_ip
		response = RestClient.get 'https://www.meethue.com/api/nupnp'
		bridge = JSON.parse(response)[0]
		@bridge_ip = bridge['internalipaddress'] 
	end
	
	def state(old_state)
	  	new_state = false
  		if old_state == "true"
  			new_state = false	
  		else 
  			new_state = true
  		end
  		return new_state
	end
	
end