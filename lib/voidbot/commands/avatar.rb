module VoidBot

  module Commands

    module Avatar
      extend Discordrb::Commands::CommandContainer

      command(:avatar, description: 'Affiche un avatar en grand.', usage: '!avatar <user>', min_args: 1, max_args: 2) do |event, *args|
	if event.message.mentions.empty?
	  event.respond("Merci de mentionner la personne dont vous souhaitez obtenir l'avatar.")
	  return
	end

        user = event.message.mentions[0]
	size = '1024'

	size = args[1] if args.size == 2
        event.respond("#{user.avatar_url('png')}?size=#{size}")

	#IO.copy_stream(open(url), 'data/avatars/#{id}.png')	
      end
    end
  end
end
