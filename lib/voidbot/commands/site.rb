module VoidBot

  module Commands

    module Site
      extend Discordrb::Commands::CommandContainer

      command([:site, :lien, :link, :forum], description: 'Affiche le lien du site.', usage: '!site') do |event|
        event.respond("Le site est disponible à cette adresse: https://dotvoid.io :hugging:")
      end
    end
  end
end
