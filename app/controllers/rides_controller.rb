class RidesController < ApplicationController

	def index
		@rides = Ride.all
	end

	def show
		@ride = Ride.find(params[:id])
	end

	def new
	end

	def edit
	end

	def create
		@ride = Ride.new(ride_params)
		@ride.save
		redirect_to @ride
	end

	def update
	end

	def destroy
	end

	private
	def ride_params
		params.require(:ride).permit(:date, :price, :rider_count, :rider_names, :ride_complete)
	end


end
