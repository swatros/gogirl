class IncidentsController < ApplicationController

  def index
    @journey = Journey.find(params[:journey_id])
    @incidents = @journey.incidents
    if @incidents.empty?
      redirect_to root_path
    end
  end

  def new
    @incident = Incident.new
  end

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
        format.html { redirect_to incident_survey_success_path(@incident) } #change to redirect to survey
        format.text { render partial: 'shared/incident_flash', locals: { message: "Location and time saved. We'll ask for more info later." }, formats: [:html] }
      else
        format.html { redirect_to root_path } #change to redirect to same page with an error
        format.text { head 422 }
      end
    end
  end

  def edit
    @incident = Incident.find(params[:id])
  end

  def update
    @incident = Incident.find(params[:id])
    @incident.update(incident_params)

    if @incident.save
      redirect_to incident_survey_success_path(@incident)
    else
      render :edit
    end
  end

  def destroy
    @incident = Incident.find(params[:id])
    @journey = @incident.journey
    @incident.destroy
    redirect_to journey_incidents_path(@journey)
  end

  private

  def incident_params
    params.require(:incident).permit(:date, :time, :latitude, :longitude, :location, :crime, :description)
  end
end
