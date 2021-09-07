class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :navigation ]

  def home
  end

  def navigation
  end

  def uikit

  end
end
