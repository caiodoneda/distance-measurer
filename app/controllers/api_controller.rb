require 'http'
require 'json'

class ApiController < ApplicationController
	before_action :authenticate_user!

	def index
	end

	def distance
		address1 = params[:address1]
		address2 = params[:address2]

		if address1.blank? or address2.blank?
			return render json: {error: 'Missing params'}
		end
		
		response = HTTP.get('https://maps.googleapis.com/maps/api/distancematrix/json', 
		      :params => { :origins => address1, 
		      	           :destinations => address2, 
		      	           :mode => 'driving',
		      	           :departure_time => 'now',
		      	           :key => 'AIzaSyBHcfHe8sW-QhqkfhTZygv6nRsSY8zt6xU'})	

		response = JSON.parse(response)

		render json: response['rows'].first['elements'].first['distance']['value']
	end
end
