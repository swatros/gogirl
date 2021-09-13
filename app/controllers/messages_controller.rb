class MessagesController < ApplicationController

  def create
    account_sid = 'ACaefaa407a07dd563fa2d0f3abcb38c3f'
    @client = Twilio::REST::Client.new(account_sid, ENV["TWILIO_TOKEN"])
    @user_name = "#{current_user.first_name} #{current_user.last_name}"


    if params[:journey]
      @journey = Journey.find(params[:journey])
      message_body = "#{@user_name} is walking and wants to share her/his live location with you:
                                #{url_for(@journey)}"
    else
      message_body = "#{@user_name} is walking and wants to share her/his current location with you:
                                https://www.google.com/maps/place/#{params[:latitude]},#{params[:longitude]}"
    end
    # current_user.contacts.each do |contact|
      #@client.messages.create(
      #                           body: message_body,
        #                          messaging_service_sid: 'MGc8e82bd2375ee0b98bdf078c9a5004af',
        #                         to: "#{contact.phone_number}"
          #                        )
    # end

    puts message_body

    if params[:journey]
      respond_to do |format|
        format.html { redirect_to root_path } #change to redirect to survey
        format.text { render partial: 'shared/incident_flash', locals: { message: "Location shared with your emergency contacts" }, formats: [:html] }
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path } #change to redirect to survey
        format.text { render partial: 'shared/incident_flash', locals: { message: "Message sent to your emergency contacts" }, formats: [:html] }
      end
    end
  end
end
