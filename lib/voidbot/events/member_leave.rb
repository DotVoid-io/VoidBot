module VoidBot
  module Events
    
    module LeaveMessage
      extend Discordrb::EventContainer

      # Send a message when a member left the server
      member_leave do |event|
        unless event.server.bans.include? event.user
          event.server.text_channels.find{ |channel| channel.id == CONFIG.welcome_channel }.send_message("Oh, #{event.member.username}##{event.member.discriminator} nous a quittés <:nothappy:449891097381044224>")
        end
      end
    end
  end
end
