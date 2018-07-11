module VoidBot

  module Commands

    # Prints most useful information about the bot.
    module About
      extend Discordrb::Commands::CommandContainer
      command(:about, description: 'Affiche les informations du bot.') do |event|

        event.channel.send_embed do |e|
          e.color = 5800090
          e.author = {
            icon_url: BOT.profile.avatar_url,
            name: 'VoidBot',
            url: 'https://dotvoid.io'
          }
          e.description = "Je suis le **VoidBot**. Concretement, j'suis le stagiaire qui fait les photocopies. Voila voila."

          e.add_field name: '__Infos:__', value: "**Développeur:** <@456845128116469790>  \n**GitHub:** [github.com/triinoxys/VoidBot](https://github.com/triinoxys/VoidBot)  \n**Mail:** contact@triinoxys.fr", inline: true
          # e.add_field name: '__Colonne 2:__', value: "blblbl", inline: true

          e.footer = { text: "VoidBot v#{VERSION} by triinoxys" }
        end
      end
    end
  end
end
