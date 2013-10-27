class TweetsController < ApplicationController
  before_action :set_tweeter, only: :new

  def new
    # @tweeter =
  end

  def create
    @tweeter = Tweeter.find(tweet_params[:tweeter_id])
    client = @tweeter.client
    begin
      client.update(tweet_params[:body])
      Tweet.create(body: tweet_params[:body], tweeter_id: @tweeter.id, sender_id: current_user.id)
      redirect_to root_path, notice: "Your tweet was sent as @#{@tweeter.screen_name}!"
    rescue => e
      logger.info e
      redirect_to root_path, notice: "There was an error sending your tweet."
    end
  end

  private
    def tweet_params
      params.require(:tweet).permit(:body, :tweeter_id)
    end

    def set_tweeter
      @tweeter = Tweeter.find(params[:id]) if params[:id]
      @tweeter ||= Tweeter.find_by(screen_name: params[:screen_name])
      @tweeter ||= current_user
    end

end
