class LightsController < ApplicationController
  before_action :set_light, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  require './lib/lp_hue.rb'
  require './lib/lp_weather.rb'

  # GET /lights
  # GET /lights.json
  def index
    #@lights = Light.all
    hue = LPHue.new
    @l = hue.discover_lights
  end

  def flip_light  
  	light_key = params['key']
  	old_state = params['state']
  	
  	current_weather = LPWeather.new
  	color_hash = current_weather.weather
  
	hue = LPHue.new
	hue.flip_light_with_colors(light_key, old_state, color_hash)

	index

  	redirect_to :controller=>'presets',:action=>'index'   	 
  end

  # GET /lights/1
  # GET /lights/1.json
  def show
  end

  # GET /lights/new
  def new
    @light = Light.new
  end

  # GET /lights/1/edit
  def edit
  end

  # POST /lights
  # POST /lights.json
  def create
    @light = Light.new(light_params)

    respond_to do |format|
      if @light.save
        format.html { redirect_to @light, notice: 'Light was successfully created.' }
        format.json { render :show, status: :created, location: @light }
      else
        format.html { render :new }
        format.json { render json: @light.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lights/1
  # PATCH/PUT /lights/1.json
  def update
    respond_to do |format|
      if @light.update(light_params)
        format.html { redirect_to @light, notice: 'Light was successfully updated.' }
        format.json { render :show, status: :ok, location: @light }
      else
        format.html { render :edit }
        format.json { render json: @light.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lights/1
  # DELETE /lights/1.json
  def destroy
    @light.destroy
    respond_to do |format|
      format.html { redirect_to lights_url, notice: 'Light was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_light
      @light = Light.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def light_params
      params.require(:light).permit(:name, :key)
    end
    
end
