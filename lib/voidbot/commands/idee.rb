module VoidBot

  module Commands

    module Idee
      extend Discordrb::Commands::CommandContainer

      command([:idee, :idée, :proposition], description: 'Propose une idée pour le site, le discord, le bot, etc.', usage: '!idee <titre> | <idée...>', min_args: 2) do |event, *args|
#	event.message.delete

        args = args.join(' ').split('|')
	titre = args[0]	
	idee = args[1..args.size-1].join(' ')
	
	message = event.server.text_channels.find{ |channel| channel.id == CONFIG.ideas_channel.to_i}.send_embed do |e|
          e.color = 5800090

	  e.author = {
            icon_url: event.user.avatar_url,
            name: event.user.name,
          }

          e.title = titre.capitalize
	  e.description = idee
        end

	response = event.respond("Votre idée a bien été proposée! <##{CONFIG.ideas_channel.to_i}>")

	Thread.new {
	  Thread.current[:discordrb_name] = 'react-delay'
	  message.react("👍")
	  sleep(0.3)
	  message.react("👎")
	}.join

#	Thread.new {
#	  Thread.current[:discordrb_name] = 'delete-delay'
#	  sleep 3.5
#	  response.delete 
#	}.join

        return
      end

    end
  end
end
