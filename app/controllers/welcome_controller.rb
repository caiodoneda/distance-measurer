require 'http'
require 'json'

class WelcomeController < ApplicationController
  def index
    driving = ''
  	map = {:origin => 'Praça XV de Novembro - Rua Tenente Silveira - Centro, Florianópolis - SC',
  		   :destination => 'Shopping Iguatemi, Florianópolis - Santa Monica, State of Santa Catarina'}
  	  	
  	if params[:origin] != nil
  		origin = params[:origin]
  		map[:origin] = params[:origin]
  	end

  	if params[:destination] != nil
  		destination = params[:destination]
  		map[:destination] = params[:destination]
  	end
    	
  	driving = HTTP.get('https://maps.googleapis.com/maps/api/distancematrix/json', 
		      :params => { :origins => map[:origin], 
		      	           :destinations => map[:destination], 
		      	           :mode => 'driving',
		      	           :departure_time => 'now',
		      	           :key => 'AIzaSyBHcfHe8sW-QhqkfhTZygv6nRsSY8zt6xU'})
  	
  	@welcome = {origin: origin, destination: destination, driving: JSON.parse(driving), map: map}
  end
end
