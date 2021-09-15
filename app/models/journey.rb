class Journey < ApplicationRecord
  attr_accessor :share_location

  belongs_to :user, optional: true
  has_many :incidents

  def share_location(message = "#{user&.full_name} is walking and wants to share her/his live location with you:")
    return if self.id.nil?

    account_sid = 'ACaefaa407a07dd563fa2d0f3abcb38c3f'
    client = Twilio::REST::Client.new(account_sid, ENV["TWILIO_TOKEN"])

    base_url = if Rails.env == "development"
      "http://localhost:3000"
    else
      "http:www.gogirlapp.me"
    end

    message_body = "#{message} #{base_url + Rails.application.routes.url_helpers.journey_path(self)}"

    # user.contacts.each do |contact|
      #client.messages.create(
      #                           body: message_body,
        #                          messaging_service_sid: 'MGc8e82bd2375ee0b98bdf078c9a5004af',
        #                         to: "#{contact.phone_number}"
          #                        )
    # end

    puts "😂 #{message_body} 😂"
  end
end
