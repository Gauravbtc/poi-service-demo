# frozen_string_literal: true
# this controller is used to store point of interest of users

module Api::V1
  class LocationsController < ApiBaseController
    before_action :set_location, only: [:show, :update, :destroy]

    def index
      locations = @user.locations
      json_response({ success: true,
                      message: "Locations list",
                      data: locations })
    end

    def show
      json_response({ success: true, message: 'Location details', data: @location })
    end

    def create
      ## verify user input parameters
      parameter_missing?(%w[address user_id], location_params)
      location = Location.new(location_params)
      if location.save
        json_response({ success: true, message: 'Location created', data: location })
      else
        json_response({ success: false, message: 'Error Occured During location create', data: location.errors })
      end
    end

    def update
      ## verify user input parameters

      parameter_missing?(%w[address user_id], location_params)
      if @location.update(location_params)
        json_response({ success: true, message: 'Locations updated', data: @location })
      else
        json_response({ success: false, message: 'Error Occured During location create', data: @location.errors })
      end
    end

    def destroy
      @location.destroy
      json_response({ success: true, message: 'Locations deleted successfully', data: {} })
    end

    def create_route
     ## verify user input parameters
      parameter_missing?(%w[locations], params)
      success, message , data = RoutesDetails::CreateRoute.new(params[:locations]).create
      json_response({ success: success, message: message, data: data })
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def location_params
      params.require(:location).permit(:address,:user_id)
    end

  end
end