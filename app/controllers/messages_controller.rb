class MessagesController < ApplicationController
  	skip_before_action :verify_authenticity_token
  	def reply
  		message_body = params["Body"]
  		from_number = params["From"]

      #names needs to not have spaces between the names/commas
  		date_string, price, names, payment_status  = message_body.split(" ")
      date_formatted = Date.strptime(date_string, "%m/%d/%Y")

      puts message_body
      count = names.split(",").length
      if payment_status == "paid"
        ride_complete = true
      else
        ride_complete = false
      end

  		boot_twilio

      #update page without refreshing

      if from_number == "+19167535026"
        puts "got in"
        Ride.create!(
        date: date_formatted,
        price: price,
        rider_names: names,
        rider_count: count,
        ride_complete: ride_complete)
      end

      # Ride.create!(
      #   date: date_formatted,
      #   price: price,
      #   rider_names: names,
      #   rider_count: count,
      #   ride_complete: ride_complete)

  		# if message_body == "Yessir"
			 #  sms = @client.messages.create(
    #   		from: Rails.application.secrets.twilio_number,
    #   		to: from_number,
    #   		body: "You said yessir"
    # 	)  			
  		# else
	  	# 	sms = @client.messages.create(
	   #    		from: Rails.application.secrets.twilio_number,
	   #    		to: from_number,
	   #    		body: "You didnt say yessir"
	   #  	)
	  	# end
  	end

  	private
  	def boot_twilio
    	account_sid = Rails.application.secrets.twilio_sid
    	auth_token = Rails.application.secrets.twilio_token
    	@client = Twilio::REST::Client.new account_sid, auth_token
  	end
end
