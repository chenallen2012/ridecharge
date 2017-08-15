class RidesController < ApplicationController

	def index
		@rides = Ride.all.order('date desc')
	end

	def show
		@ride = Ride.find(params[:id])
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

		if @ride.update(ride_params)
			redirect_to @ride
		else
			render 'edit'
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
