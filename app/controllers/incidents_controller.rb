class IncidentsController < ApplicationController

  def create
    @journey = Journey.find_by(id: params[:journey_id])

    if @journey
      @incident = Incident.new(date: Date.today, time: Time.now)
      @incident.journey = @journey
      @incident.user = @journey.user
    else
      @incident = Incident.new(incident_params)
      @incident.user = current_user
    end

    respond_to do |format|
      if @incident.save
        format.html { redirect_to root_path } #change to redirect to survey
        format.json { head 200 }
      else
        format.html { redirect_to root_path } #change to redirect to same page with an error
        format.json { head 422 }
      end
    end
  end

  private

  def incident_params
    params.require(:incident).permit(:date, :time)
  end
end
