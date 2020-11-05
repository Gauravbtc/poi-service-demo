class LocationsController < ApplicationController
   before_action :set_location, only: [:show, :edit, :update, :destroy]

  def index
    @locations = Location.all
  end

  def new
    @location = Location.new
  end

  def edit
  end

  def create
    @location = Location.new(location_params)
    @location.user_id = current_user.id
    respond_to do |format|
      if @location.save
        format.html { redirect_to locations_path, notice: 'POI successfully created.' }
        format.json { render json: @location, status: :ok }
      else
        format.html { render :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    # respond_to do |format|
    #   if @location.present?
    #     format.html { redirect_to location_path(@location), notice: 'Trip was successfully updated.' }
    #     format.json { render json: @location }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @location.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  def update
    respond_to do |format|
      if @location.update(location_params.merge(user_id: current_user.id))
        format.html { redirect_to location_path(@location), notice: 'Trip was successfully updated.' }
        format.json { render json: @location }
      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url, notice: 'Trip was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def location_params
      params.require(:location).permit(:address, :user_id,:latitude, :longitude)
    end
end
