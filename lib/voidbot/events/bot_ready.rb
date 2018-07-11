module VoidBot
  module Events
    module BotReady
      extend Discordrb::EventContainer
      
      ready do |event|
	BOT.game = "dotvoid.io | !help"
      end
    end
  end
end
