# frozen_string_literal: true
# this controller is used to store point of interest of users

module Api::V1
  class LocationsController < ApiBaseController
    before_action :set_location, only: [:show, :update, :destroy]

    def index
      locations = @user.locations
      location_response(true, I18n.t("locations.list"), locations)
    end

    def show
      location_response(true, I18n.t("locations.show"), @location)
    end

    def create
      ## verify user input parameters
      parameter_missing?(%w[address user_id], location_params)
      location = Location.new(location_params)
      if location.save
        location_response(true, I18n.t("locations.created"), location)
      else
        location_response(false, I18n.t("locations.errors", msg: "create"), location.errors)
      end
    end

    def update
      ## verify user input parameters
      parameter_missing?(%w[address user_id], location_params)
      if @location.update(location_params)
        location_response(true, I18n.t("locations.updated"), @location)
      else
        location_response(false, I18n.t("locations.errors", msg: "update"), location.errors)
      end
    end

    def destroy
      @location.destroy
      location_response(true, I18n.t("deleted"), {})
    end

    def create_route
     ## verify user input parameters
      parameter_missing?(%w[locations], params)
      success, message , data = RoutesDetails::CreateRoute.new(params[:locations]).create
      location_response(success, message, data)
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

    def location_response(success, message, data)
      json_response({ success: success, message: message, data: data })
    end
  end
end