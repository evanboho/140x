class TweetersController < ApplicationController
  before_action :set_tweeter, only: [:show, :edit, :update, :destroy]

  def index
    @tweeters = Tweeter.all
  end

  def show
    # redirect_to tweeter_grants_path(@tweeter) unless @tweeter.grants.present?
  end

  def new
    @tweeter = Tweeter.new
  end

  def edit
  end

  def create
    @tweeter = Tweeter.new(tweeter_params)

    respond_to do |format|
      if @tweeter.save
        format.html { redirect_to @tweeter, notice: 'Tweeter was successfully created.' }
        format.json { render action: 'show', status: :created, location: @tweeter }
      else
        format.html { render action: 'new' }
        format.json { render json: @tweeter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweeters/1
  # PATCH/PUT /tweeters/1.json
  def update
    respond_to do |format|
      if @tweeter.update(tweeter_params)
        format.html { redirect_to @tweeter, notice: 'Tweeter was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tweeter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweeters/1
  # DELETE /tweeters/1.json
  def destroy
    @tweeter.destroy
    respond_to do |format|
      format.html { redirect_to tweeters_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweeter
      @tweeter = Tweeter.find(params[:id]) if params[:id]
      @tweeter ||= Tweeter.find_by(screen_name: params[:screen_name])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tweeter_params
      params.require(:tweeter).permit(:handle, :oauth_token)
    end
end
