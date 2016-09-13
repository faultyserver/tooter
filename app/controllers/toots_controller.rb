class TootsController < ApplicationController
  before_action :set_toot, only: [:destroy]

  # Users must be signed in to create/edit/destroy Toots, but they are allowed
  # to view existing Toots.
  before_action :authorize

  # GET /toots/new
  def new
    @toot = Toot.new
  end

  # POST /toots
  def create
    @toot = Toot.new(toot_params)

    if @toot.save
      redirect_to user_path(current_user), notice: 'Toot was successfully created.'
    else
      render :new
    end
  end

  # DELETE /toots/1
  def destroy
    @toot.destroy
    redirect_to user_path(current_user), notice: 'Toot was successfully destroyed.'
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
