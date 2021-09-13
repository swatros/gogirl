class EmergencyNumbersController < ApplicationController

  def show
    puts "heklña"
    render json: EmergencyNumber.get_country(params[:iso])
  end

end
