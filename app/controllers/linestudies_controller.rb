class LinestudiesController < ApplicationController
  before_action :set_linestudy, only: [:show, :edit, :update, :destroy]

  # GET /linestudies
  # GET /linestudies.json
  def index
    @linestudies = Linestudy.all
  end

  # GET /linestudies/1
  # GET /linestudies/1.json
  def show
  end

  # GET /linestudies/new
  def new
    @linestudy = Linestudy.new
  end

  # GET /linestudies/1/edit
  def edit
  end

  # POST /linestudies
  # POST /linestudies.json
  def create
    @linestudy = Linestudy.new(linestudy_params)

    respond_to do |format|
      if @linestudy.save
        format.html { redirect_to @linestudy, notice: 'Linestudy was successfully created.' }
        format.json { render action: 'show', status: :created, location: @linestudy }
      else
        format.html { render action: 'new' }
        format.json { render json: @linestudy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /linestudies/1
  # PATCH/PUT /linestudies/1.json
  def update
    respond_to do |format|
      if @linestudy.update(linestudy_params)
        format.html { redirect_to @linestudy, notice: 'Linestudy was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @linestudy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /linestudies/1
  # DELETE /linestudies/1.json
  def destroy
    @linestudy.destroy
    respond_to do |format|
      format.html { redirect_to linestudies_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_linestudy
      @linestudy = Linestudy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def linestudy_params
      params.require(:linestudy).permit(:name, :description, :type, :user_id, :start_time, :end_time)
    end
end
