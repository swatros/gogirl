class MessagesController < ApplicationController

  def create
    if params[:journey]
      @journey = Journey.find(params[:journey])
      @journey.share_location
    end

    if params[:journey]
      respond_to do |format|
        format.html { redirect_to root_path } #change to redirect to survey
        format.text { render partial: 'shared/incident_flash', locals: { message: "Location shared with your emergency contacts" }, formats: [:html] }
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path } #change to redirect to survey
        format.text { render partial: 'shared/incident_flash', locals: { message: "Message sent to your emergency contacts" }, formats: [:html] }
      end
    end
  end
end
