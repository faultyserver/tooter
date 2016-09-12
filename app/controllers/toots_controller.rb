class TootsController < ApplicationController
  before_action :set_toot, only: [:show, :edit, :update, :destroy]

  # Users must be signed in to create/edit/destroy Toots, but they are allowed
  # to view existing Toots.
  before_action :authorize, except: [:index, :show]

  # GET /toots
  def index
    @toots = Toot.all
  end

  # GET /toots/1
  def show
  end

  # GET /toots/new
  def new
    @toot = Toot.new
  end

  # GET /toots/1/edit
  def edit
  end

  # POST /toots
  def create
    @toot = Toot.new(toot_params)

    if @toot.save
      redirect_to @toot, notice: 'Toot was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /toots/1
  def update
    if @toot.update(toot_params)
      redirect_to @toot, notice: 'Toot was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /toots/1
  def destroy
    @toot.destroy
    redirect_to toots_url, notice: 'Toot was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_toot
      @toot = Toot.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def toot_params
      params.require(:toot).permit(:body).merge(author_id: current_user.id)
    end
end
