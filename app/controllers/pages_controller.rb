require 'json'

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :navigation]

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

  private

  def draw_box(incident)
    latitude = incident.latitude
    longitude = incident.longitude
    radius = 0.002
    top_left_lat = latitude + radius / 2
    top_left_lng = longitude + radius
    bottom_right_lat = latitude - radius / 2
    bottom_right_lng = longitude - radius
    return "bbox:#{top_left_lng},#{top_left_lat},#{bottom_right_lng},#{bottom_right_lat}"
  end

  def combine_boxes(incidents)
    incidents.map{ |incident| draw_box(incident) }.join('|')
  end
end
