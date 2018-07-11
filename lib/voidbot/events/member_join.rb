module VoidBot
  module Events
    # Say welcome to new users
    module JoinMessage
      extend Discordrb::EventContainer
      member_join do |event|
        event.server.text_channels.find{ |channel| channel.id == CONFIG.welcome_channel }.send_message("Hop hop, on a un nouveau!  \nBienvenue à <@#{event.member.id}> :smiley:")
      end
    end

    # Send a PM to new users
    module JoinPM
      extend Discordrb::EventContainer
      
      member_join do |event|
        event.user.pm("Bienvenue sur le discord de VoidBot! ✌️\n\n __Voici quelques trucs à savoir:__\n - On a quand mêmes quelques règles, check le salon #regles\n - Si tu veux un rôle spécifique, tu peux utiliser la commande `!role`\n - Surveille les salons #annonces, #sondages et #debats pour être au courant de tout et participer à l'évolution du site!")
      end
    end

    # Auto add a role to new users, like the 'new-member' role
    module AutoRole
      extend Discordrb::EventContainer

      member_join do |event|
        event.user.add_role('371335759640133636') unless event.user.bot_account
      end
    end

  end
end
