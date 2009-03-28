class WelcomeController < ApplicationController
	def index
		@top10 = User.find(:all, :order => 'points DESC', :limit => 10)
	end
end
