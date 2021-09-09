class IncidentsController < ApplicationController

  def create
    @journey = Journey.find_by(id: params[:journey_id])
    @incident = Incident.new(incident_params)

    if @journey
      @incident.date = Date.today
      @incident.time = Time.now

      @incident.journey = @journey
      @incident.user = @journey.user
    else
      @incident.user = current_user
    end

    respond_to do |format|
      if @incident.save
        format.html { redirect_to root_path } #change to redirect to survey
        format.text { render partial: 'shared/incident_flash', locals: { message: "Location and time saved. We'll ask for more info later." }, formats: [:html] }
      else
        format.html { redirect_to root_path } #change to redirect to same page with an error
        format.text { head 422 }
      end
    end
  end

  private

  def incident_params
    params.require(:incident).permit(:date, :time, :latitude, :longitude)
  end
end
