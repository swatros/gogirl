class MessagesController < ApplicationController

  def create
    account_sid = 'ACaefaa407a07dd563fa2d0f3abcb38c3f'
    @client = Twilio::REST::Client.new(account_sid, ENV["TWILIO_TOKEN"])
    @user_name = "#{current_user.first_name} #{current_user.last_name}"
    current_user.contacts.each do |contact|
    message = @client.messages.create(
                                body: "#{@user_name} is walking and wants to share her/his current location with you:
                                https://www.google.com/maps/place/#{params[:latitude]},#{params[:longitude]}",
                                messaging_service_sid: 'MGc8e82bd2375ee0b98bdf078c9a5004af',
                                to: "#{contact.phone_number}"
                                )
    end

    puts "https://www.google.com/maps/place/#{params[:latitude]},#{params[:longitude]}"
  end
end
