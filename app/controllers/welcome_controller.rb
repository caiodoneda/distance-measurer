require 'http'
require 'rubygems'
require 'json'

class WelcomeController < ApplicationController
  def index
  	if params[:origin] != nil
  		origin = params[:origin]
	  	response = JSON.parse(HTTP.get('https://maps.googleapis.com/maps/api/geocode/json', 
	  		                      :params => { :address => origin, 'key' => 'AIzaSyBHcfHe8sW-QhqkfhTZygv6nRsSY8zt6xU'}))
	  	
	  	origin_geocode = response['results'].last['geometry']['location']
  	else
  		origin = ''
  		origin_geocode = ''
	end

	if params[:destination] != nil
  		destination = params[:destination]
	  	response = JSON.parse(HTTP.get('https://maps.googleapis.com/maps/api/geocode/json', 
	  		                      :params => { :address => destination, 'key' => 'AIzaSyBHcfHe8sW-QhqkfhTZygv6nRsSY8zt6xU'}))
	  	destination_geocode = response['results'].last['geometry']['location']
  	else
  		destination = ''
  		destination_geocode = ''	
  	end

  	puts 

  	@welcome = {origin: origin, origin_geocode: origin_geocode, destination: destination, destination_geocode: destination_geocode}
  end
end
