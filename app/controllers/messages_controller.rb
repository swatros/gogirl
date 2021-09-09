class MessagesController < ApplicationController

  def create
    account_sid = 'ACaefaa407a07dd563fa2d0f3abcb38c3f'
    @client = Twilio::REST::Client.new(account_sid, ENV["TWILIO_TOKEN"])

    current_user.contacts.each do |contact|
      message = @client.messages.create(
                                body: 'helllo',
                                messaging_service_sid: 'MGc8e82bd2375ee0b98bdf078c9a5004af',
                                to: "#{contact.phone_number}"
                              )
                              puts message.status
      end
  end
end
