class JourneyChannel < ApplicationCable::Channel
  def subscribed
    journey = Journey.find(params[:id])
    stream_for journey
  end
end
