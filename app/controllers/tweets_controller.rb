class TweetsController < ApplicationController

  def create
    @tweeter = Tweeter.find(tweet_params[:tweeter_id])
    client = @tweeter.client
    begin
      client.update(tweet_params[:body])
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

end
