require 'json'

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :navigation ]

  def navigation
    @origin = Geocoder.search(params[:origin]).first.coordinates.to_json
    @destination = Geocoder.search(params[:destination]).first.coordinates.to_json
    @journey = Journey.create(user: current_user, origin_address: params[:origin], destination_address: params[:destination])
  end

end
