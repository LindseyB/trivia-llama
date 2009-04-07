class LolprocesstweetsController < ApplicationController
	def index
		require('rubygems')
		gem('mbbx6spp-twitter4r', '0.3.1')
		require('twitter')

		client = Twitter::Client.new(:login => 'username',
	    							 :password => 'password')

		earlier = Time.new - 60*10*60 # last 10 minutes
		tl = client.timeline_for(:friends, :since => earlier, :count => 1000)

		# grab out all @ replies
		@timeline = tl.select { |t| t.text =~ /^@triviallama/i }

		#take off the @triviallama
		@timeline = @timeline.collect { |t|  t.text.gsub!(/@triviallama /i, ''); t}

		#now match vs the db
		current_question = Currentq.find(:first)
		@question = Question.find_by_id(current_question.num)

		@correct = @timeline.collect { |t| t.text = t.text.downcase; t;}
		@answer = @question.answer.downcase
		@correct = @timeline.select { |t| t.text.downcase == @question.answer.downcase  }
		if(@correct.length > 0)
			@winrar_name = @correct.reverse
			@winrar_name = @winrar_name[0].user.screen_name

			#find the user with that user name
			@winrar = User.find_by_login(@winrar_name)
			@before_points = @winrar.points

			@winrar.points += 1

			@after_points = @winrar.points
			@winrar.save

			redirect_to "/lolprocesstweets/newquestion"
		else
		end

	end

	def newquestion
		# grab the current question
		current_question = Currentq.find(:first)
		# figure out how many we have
		count = Question.find(:all).length

		# update the number to something random
		current_question.num = 1 + rand(count)
		current_question.save

		# find the question that we're looking at
		@question = Question.find_by_id(current_question.num)

		# send out a message with the question's text
		client = Twitter::Client.new(:login => 'triviallama',
																   :password => '1337hax')
		client.status(:post, @question.body)

	end

end
