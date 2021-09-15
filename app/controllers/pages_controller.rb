require 'json'

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :splash ]

  def home
    redirect_to splash_path unless user_signed_in?
  end

  def navigation
    @origin = Geocoder.search(params[:origin]).first.coordinates
    @destination = Geocoder.search(params[:destination]).first.coordinates
    @distance = Geocoder::Calculations.distance_between(@origin, @destination)
    @midpoint = Geocoder::Calculations.geographic_center([@origin, @destination])
    @incidents = Incident.near(@midpoint, @distance)
    @incidents = @incidents.map do |incident|
      {
        lat: incident.latitude,
        lng: incident.longitude,
        bbox: draw_box(incident)
      }
    end
    @incidents_avoid = combine_boxes(Incident.order(date: :desc).limit(20))
    @journey = Journey.create(user: current_user, origin_address: params[:origin], destination_address: params[:destination])
  end

  def uikit
  end

  def survey
    @incident = Incident.last
  end

  def survey_success
    @incident = Incident.find(params[:incident_id])
    @journey = @incident.journey
  end
end
