class RidesController < ApplicationController

	def index
		@rides = Ride.all.order('date desc')
	end

	def show
		@ride = Ride.find(params[:id])
		puts @ride.ride_complete
	end

	def new
		@ride = Ride.new
	end

	def edit
		@ride = Ride.find(params[:id])
	end

	def create
		@ride = Ride.new(ride_params)
		
		if @ride.save
			redirect_to @ride
		else
			render 'new'
		end
	end

	def update
		@ride = Ride.find(params[:id])
		puts 'test'
		puts params[:ride_complete]
		puts 'end'
		puts 'ride_params: '
		puts ride_params[:ride_complete]
		puts 'end ride_params'
		# if params[:ride_complete]

		if @ride.update(ride_params)
			# redirect_to @ride
			render json: @ride
		else
			render 'edit'
		end
	end

	def toggle_payment_status
		@ride = Ride.find(params[:id])
		if @ride.update_attributes(:ride_complete => params[:payment_status])
			# render status: @ride.ride_complete, status: 200
			render :json => @ride.ride_complete
		else
			render :json => 'Error'
		end

	end


	def destroy
		@ride = Ride.find(params[:id])
		@ride.destroy

		redirect_to rides_path
	end

	private
	def ride_params
		params.require(:ride).permit(:date, :price, :rider_count, :rider_names, :ride_complete)
	end


end
