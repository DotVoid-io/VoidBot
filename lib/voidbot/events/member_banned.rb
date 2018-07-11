module VoidBot
  module Events
    module BanMessage
      extend Discordrb::EventContainer
      
      user_ban do |event|
        event.server.text_channels.find{ |channel| channel.id == CONFIG.welcome_channel }.send_message("<@#{event.user.id}> a été banni! :rage:")
      end
    end
  end
end
