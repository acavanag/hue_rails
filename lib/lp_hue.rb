
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
		RestClient.put "http://#{bridge_ip}/api/newdeveloper/lights/#{light_key}/state", {:on => light_state}.to_json
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
	
end