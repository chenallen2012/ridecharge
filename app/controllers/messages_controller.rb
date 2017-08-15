class MessagesController < ApplicationController
  	# skip_before_filter :verify_authenticity_token
  	skip_before_action :verify_authenticity_token
  	def reply
  		message_body = params["Body"]
  		from_number = params["From"]
  		# date, price, names
  		date, price, names = message_body.split(" ")
  		
  		puts date
  		puts price
  		puts names
      puts message_body
      count = names.split(",").length

  		boot_twilio

  		#need to parse the date correctly. 8/11/2017 is interpreted as 11/8/2017
      #need to include rider count DONE
      #sorts rides by most recent DONE
      #update page without refreshing
      #secrets file 

      Ride.create!(
        date: date,
        price: price,
        rider_names: names,
        rider_count: count)

  		if message_body == "Yessir"
			  sms = @client.messages.create(
      		from: Rails.application.secrets.twilio_number,
          # from: Rails.application.secrets[:twilio_number],
      		to: from_number,
      		body: "You said yessir"
    	)  			
  		else
	  		sms = @client.messages.create(
	      		from: Rails.application.secrets.twilio_number,
            # from: Rails.application.secrets[:twilio_number],
	      		to: from_number,
	      		body: "You didnt say yessir"
	    	)
	  	end
  	end

  	private
  	def boot_twilio
    	account_sid = Rails.application.secrets.twilio_sid
      # account_sid = Rails.application.secrets[:twilio_sid]
    	auth_token = Rails.application.secrets.twilio_token
      # auth_token = Rails.application.secrets[:twilio_token]
    	@client = Twilio::REST::Client.new account_sid, auth_token
  	end
end