class PresetsController < ApplicationController
  before_action :set_preset, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token
  
  require './lib/lp_hue.rb'

  # GET /presets
  # GET /presets.json
  def index
    @presets = Preset.all
  end

  # GET /presets/1
  # GET /presets/1.json
  def show
  	@preset = Preset.find(params[:id])
  	
	hue = LPHue.new
	@lights = hue.discover_lights
	
  	
  end

  # GET /presets/new
  def new
    @preset = Preset.new
  end
  
  def flip_light  
  	light_key = params['key']
  	old_state = params['state']
  	
  	preset = Preset.find(params[:id])
  	color_hash = {'bri' => preset.brightness.to_i, 'hue' => preset.hue.to_i, 'sat' => preset.saturtion.to_i}

	hue = LPHue.new
	hue.flip_light_with_colors(light_key, false, color_hash)
	
	index

  	render 'index'  	 
  end

  # GET /presets/1/edit
  def edit
  end

  # POST /presets
  # POST /presets.json
  def create
    @preset = Preset.new(preset_params)

    respond_to do |format|
      if @preset.save
        format.html { redirect_to @preset, notice: 'Preset was successfully created.' }
        format.json { render :show, status: :created, location: @preset }
      else
        format.html { render :new }
        format.json { render json: @preset.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /presets/1
  # PATCH/PUT /presets/1.json
  def update
    respond_to do |format|
      if @preset.update(preset_params)
        format.html { redirect_to @preset, notice: 'Preset was successfully updated.' }
        format.json { render :show, status: :ok, location: @preset }
      else
        format.html { render :edit }
        format.json { render json: @preset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /presets/1
  # DELETE /presets/1.json
  def destroy
    @preset.destroy
    respond_to do |format|
      format.html { redirect_to presets_url, notice: 'Preset was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_preset
      @preset = Preset.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def preset_params
      params.require(:preset).permit(:brightness, :saturtion, :hue)
    end
end
