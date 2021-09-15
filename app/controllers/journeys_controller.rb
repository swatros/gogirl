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
    @cluster_objects = []
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
    top_left_lng = longitude - radius
    bottom_right_lat = latitude - radius / 2
    bottom_right_lng = longitude + radius
    return "bbox:#{top_left_lng},#{top_left_lat},#{bottom_right_lng},#{bottom_right_lat}"
  end

  def define_centers(incidents)
    incidents_copy = incidents.dup
    incident_clusters = []
    incidents_copy.each do |incident|
      next if incident_clusters.any? { |cluster| cluster.include? incident }

      incident_group = Incident.near(incident, 0.33)
      incident_clusters.push(incident_group)
    end

    # incident_clusters.select! { |k| k.to_a.count > 4 }
    incident_clusters = incident_clusters.sort_by(&:size).last(20)
    combine_clusters(incident_clusters)
  end

  def combine_clusters(clusters)
    clusters.map { |cluster| cluster_box(cluster) }.join('|')
  end

  def cluster_box(cluster)
    center = Geocoder::Calculations.geographic_center(cluster)
    reach = effective_radius(cluster, center)
    radius = 0

    top_left_lat = center.first + radius + reach
    top_left_lng = center.last - reach * 1.25
    bottom_right_lat = center.first - radius - reach
    bottom_right_lng = center.last + reach * 1.25
    @cluster_objects.push({ tllng: top_left_lng,tllat: top_left_lat,brlng: bottom_right_lng,brlat: bottom_right_lat })
    "bbox:#{top_left_lng},#{top_left_lat},#{bottom_right_lng},#{bottom_right_lat}"
  end

  def effective_radius(cluster, center)
    max_lat = cluster.max_by { |incident| incident[:latitude] }.latitude
    min_lat = cluster.min_by { |incident| incident[:latitude] }.latitude
    max_lng = cluster.max_by { |incident| incident[:longitude] }.longitude
    min_lng = cluster.min_by { |incident| incident[:longitude] }.longitude
    nw_point = [max_lat, min_lng]
    se_point = [min_lat, max_lng]
    max_distance = [Geocoder::Calculations.distance_between(nw_point, center), Geocoder::Calculations.distance_between(se_point, center)].max
    [max_distance * 0.01, 0.0015].max
  end

  def pass_through(origin, destination, center)
    if Geocoder::Calculations.distance_between(origin, center) <= 0.33 || Geocoder::Calculations.distance_between(destination, center) <= 0.33
      0.0015
    else
      0.0027
    end
  end
end

# pass_through(@origin, @destination, center)
