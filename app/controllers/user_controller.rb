require 'rest-client'
require 'json'

class UserController < ApplicationController

	#GET /users
	def index
		@test = RestClient.get "http://localhost:3000/users"
		render json: @test.body
	end
end
