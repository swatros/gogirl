class IncidentsController < ApplicationController

  def create
    @user = current_user
    @incident = Incident.new(incident_params)
    @incident.user = @user

    if @journey
      @journey = Journey.find(params[:journey_id])
      @incident.journey = @journey
    end

    if @incident.save
      # has to stay on same page?
      redirect_to navigation_path(@journey)
      flash[:notice] = "Location and time saved. We'll ask for more info later."
    else
      redirect_back fallback_location: navigation_path(@journey)
      flash[:alert] = @incident.errors.full_messages.join(", ").capitalize
    end
  end
end
