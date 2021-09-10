require 'json'

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :navigation ]

  def uikit
  end

  def survey
    @incident = Incident.last
  end
end
