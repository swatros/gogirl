class JourneysController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :show ]

  def show
    @journey = Journey.find(params[:id])
    @contacts = @journey.user.contacts.select { |contact| contact.first_name != "" }
    @origin = Geocoder.search(@journey.origin_address).first.coordinates
    @destination = Geocoder.search(@journey.destination_address).first.coordinates
    @distance = Geocoder::Calculations.distance_between(@origin, @destination)
    @midpoint = Geocoder::Calculations.geographic_center([@origin, @destination])
    @incidents = Incident.near(@midpoint, @distance)
    @incidents_avoid = define_centers(@incidents)
    @incidents = @incidents.map do |incident|
      {
        lat: incident.latitude,
        lng: incident.longitude,
        bbox: solo_box(incident)
      }
    end
    render 'pages/navigation'
  end

  def create
    @journey = Journey.create(user: current_user, origin_address: params[:origin], destination_address: params[:destination])
    redirect_to journey_path(@journey)
  end

  private

  def solo_box(incident)
    latitude = incident.latitude
    longitude = incident.longitude
    radius = 0.002
    top_left_lat = latitude + radius / 2
    top_left_lng = longitude + radius
    bottom_right_lat = latitude - radius / 2
    bottom_right_lng = longitude - radius
    return "bbox:#{top_left_lng},#{top_left_lat},#{bottom_right_lng},#{bottom_right_lat}"
  end

  def define_centers(incidents)
    incidents_copy = incidents.dup
    incident_clusters = []
    incidents_copy.each do |incident|
      next if incident_clusters.any? { |cluster| cluster.include? incident }

      incident_group = Incident.near(incident, 0.3)
      incident_clusters.push(incident_group)
    end

    incident_clusters.select! { |k| k.to_a.count > 0 }
    incident_clusters = incident_clusters.sort_by(&:size).last(20)
    combine_clusters(incident_clusters)
  end

  def combine_clusters(clusters)
    clusters.map { |cluster| cluster_box(cluster) }.join('|')
  end

  def cluster_box(cluster)
      center = Geocoder::Calculations.geographic_center(cluster)
      radius = 0.002
      top_left_lat = center.first + radius / 2
      top_left_lng = center.last + radius * 2
      bottom_right_lat = center.first - radius / 2
      bottom_right_lng = center.last - radius * 2
      "bbox:#{top_left_lng},#{top_left_lat},#{bottom_right_lng},#{bottom_right_lat}"
  end
end
