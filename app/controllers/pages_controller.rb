require 'json'

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :navigation ]

  def home
  end

  def navigation
    @origin = Geocoder.search(params[:origin]).first.coordinates.to_json
    @destination = Geocoder.search(params[:destination]).first.coordinates.to_json
  end

  def uikit

  end
end
