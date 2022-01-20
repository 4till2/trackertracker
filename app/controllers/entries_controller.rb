class EntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_and_authorize, only: %i[ show edit update destroy ]

  # GET /entries or /entries.json
  def index
    @entries = Entry.where(user_id: current_user.id).order("date DESC")
  end

  # GET /entries/1 or /entries/1.json
  def show
  end

  # GET /entries/new
  def new
    @entry = Entry.new(item_id: params[:item_id])
    puts @entry.item_id
    @items = Item.where(user_id: current_user.id)
  end

  # GET /entries/1/edit
  def edit
    @items = Item.where(user_id: current_user.id)
    puts @entry.item_id
  end

  # POST /entries or /entries.json
  def create
    @entry = Entry.new(entry_params)
    @entry.user_id = current_user.id
    respond_to do |format|
      if @entry.save
        format.html { redirect_to entry_url(@entry), notice: "Entry was successfully created." }
        format.json { render :show, status: :created, location: @entry }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entries/1 or /entries/1.json
  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.html { redirect_to entry_url(@entry), notice: "Entry was successfully updated." }
        format.json { render :show, status: :ok, location: @entry }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1 or /entries/1.json
  def destroy
    @entry.destroy

    respond_to do |format|
      format.html { redirect_to entries_url, notice: "Entry was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def load_and_authorize
    @entry = Entry.find(params[:id])
    authorize @entry
  end

  # Only allow a list of trusted parameters through.
  def entry_params
    params.require(:entry).permit(:item_id, :date, :amount)
  end
end
