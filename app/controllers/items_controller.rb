class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_and_authorize, only: %i[ show edit update destroy ]

  # GET /items or /items.json
  def index
    @items = Item.where(user_id: current_user.id)
  end

  # GET /items/1 or /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
    @categories = Category.where(user_id: current_user.id)
  end

  # GET /items/1/edit
  def edit
    @categories = Category.where(user_id: current_user.id)
  end

  # POST /items or /items.json
  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    category_ids = Category.find_or_create_by_names(params[:item][:category_names], current_user.id)
    @item.category_ids = category_ids
    respond_to do |format|
      if @item.save
        format.html { redirect_to item_url(@item), notice: "Item was successfully created." }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1 or /items/1.json
  def update
    category_ids = Category.find_or_create_by_names(params[:item][:category_names], current_user.id)
    update_params = item_params.merge("category_ids" => category_ids)

    respond_to do |format|
      if @item.update(update_params)
        format.html { redirect_to item_url(@item), notice: "Item was successfully updated." }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1 or /items/1.json
  def destroy
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url, notice: "Item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def load_and_authorize
    @item = Item.find(params[:id])
    authorize @item
  end

  # Only allow a list of trusted parameters through.
  def item_params
    params.require(:item).permit(:name, :category_names)
  end
end
