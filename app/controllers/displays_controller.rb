class DisplaysController < ApplicationController
  before_action :authenticate_user!
  before_action :load_and_authorize, only: %i[ show edit update destroy ]

  # GET /displays or /displays.json
  def index
    @displays = Display.where(user_id: current_user.id)
  end

  # GET /displays/1 or /displays/1.json
  def show
  end

  # GET /displays/new
  def new
    @display = Display.new
  end

  # GET /displays/1/edit
  def edit
  end

  # POST /displays or /displays.json
  def create
    @display = Display.new(display_params)
    @display.user_id = current_user.id
    respond_to do |format|
      if @display.save
        format.html { redirect_to display_url(@display), notice: "Display was successfully created." }
        format.json { render :show, status: :created, location: @display }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @display.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /displays/1 or /displays/1.json
  def update
    respond_to do |format|
      if @display.update(display_params)
        format.html { redirect_to display_url(@display), notice: "Display was successfully updated." }
        format.json { render :show, status: :ok, location: @display }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @display.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /displays/1 or /displays/1.json
  def destroy
    @display.destroy

    respond_to do |format|
      format.html { redirect_to displays_url, notice: "Display was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def load_and_authorize
    @display = Display.find(params[:id])
    authorize @display
  end

  # Only allow a list of trusted parameters through.
  def display_params
    params.require(:display).permit(:dashboard_id, :type)
  end
end
