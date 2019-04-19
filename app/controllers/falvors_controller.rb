class FalvorsController < ApplicationController
  before_action :set_falvor, only: [:show, :edit, :update, :destroy]

  # GET /falvors
  # GET /falvors.json
  def index
    @falvors = Falvor.all
  end

  # GET /falvors/1
  # GET /falvors/1.json
  def show
  end

  # GET /falvors/new
  def new
    @falvor = Falvor.new
  end

  # GET /falvors/1/edit
  def edit
  end

  # POST /falvors
  # POST /falvors.json
  def create
    @falvor = Falvor.new(falvor_params)

    respond_to do |format|
      if @falvor.save
        format.html { redirect_to @falvor, notice: 'Falvor was successfully created.' }
        format.json { render :show, status: :created, location: @falvor }
      else
        format.html { render :new }
        format.json { render json: @falvor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /falvors/1
  # PATCH/PUT /falvors/1.json
  def update
    respond_to do |format|
      if @falvor.update(falvor_params)
        format.html { redirect_to @falvor, notice: 'Falvor was successfully updated.' }
        format.json { render :show, status: :ok, location: @falvor }
      else
        format.html { render :edit }
        format.json { render json: @falvor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /falvors/1
  # DELETE /falvors/1.json
  def destroy
    @falvor.destroy
    respond_to do |format|
      format.html { redirect_to falvors_url, notice: 'Falvor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_falvor
      @falvor = Falvor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def falvor_params
      params.require(:falvor).permit(:name, :active)
    end
end
