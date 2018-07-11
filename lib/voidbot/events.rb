module VoidBot
  
  # Module for events.
  module Events
    # Require files from directory
    Dir["#{File.dirname(__FILE__)}/events/*.rb"].each { |file| require file }

  @events = [
       Mention,
#      JoinMessage,
#      LeaveMessage,
#      BanMessage,
      BotReady,
#      JoinPM,
#      AutoRole
]

    def self.include!
      @events.each do |event|
        VoidBot::BOT.include!(event)
      end
    end
  end
end
