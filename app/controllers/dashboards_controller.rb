class DashboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_and_authorize, only: %i[ show edit update destroy ]

  # GET /dashboards or /dashboards.json
  def index
    @dashboards = Dashboard.where(user_id: current_user.id)
  end

  # GET /dashboards/1 or /dashboards/1.json
  def show
  end

  # GET /dashboards/new
  def new
    @dashboard = Dashboard.new
  end

  # GET /dashboards/1/edit
  def edit
  end

  # POST /dashboards or /dashboards.json
  def create
    @dashboard = Dashboard.new(dashboard_params)
    @display.user_id = current_user.id

    respond_to do |format|
      if @dashboard.save
        format.html { redirect_to dashboard_url(@dashboard), notice: "Dashboard was successfully created." }
        format.json { render :show, status: :created, location: @dashboard }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @dashboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dashboards/1 or /dashboards/1.json
  def update
    respond_to do |format|
      if @dashboard.update(dashboard_params)
        format.html { redirect_to dashboard_url(@dashboard), notice: "Dashboard was successfully updated." }
        format.json { render :show, status: :ok, location: @dashboard }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @dashboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dashboards/1 or /dashboards/1.json
  def destroy
    @dashboard.destroy

    respond_to do |format|
      format.html { redirect_to dashboards_url, notice: "Dashboard was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def load_and_authorize
    @dashboard = Dashboard.find(params[:id])
    authorize @dashboard
  end

  # Only allow a list of trusted parameters through.
    def dashboard_params
      params.require(:dashboard).permit(:name)
    end
end
