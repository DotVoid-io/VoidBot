module VoidBot

  module Commands

    module Emoji
      extend Discordrb::Commands::CommandContainer

      command(:emoji, description: 'Affiche un emoji en grand.', usage: '!emoji <emoji>', min_args: 1, max_args: 2) do |event, *args|
	if !event.message.emoji?
	  code = Twemoji.find_by_text(Twemoji.find_by(unicode: args[0]))
	  url = "https://twemoji.maxcdn.com/2/72x72/#{code}.png"
	else
	  code = event.message.emoji[0].name
   	  url = event.message.emoji[0].icon_url
	end

        file = "data/emojis/#{code}.png"

	if args.size >= 2 && args[1] == "--noby"
	  if code
            File.write(file, open(url).read) unless File.file? file
            event.channel.send_file(File.new(file))
            event.message.delete
          else
            event.respond("Cet emoji n'est pas (encore) possible à agrandir :disappointed_relieved: ")
          end
	else
  	  if code
	    event.channel.send_embed do |embed|
              embed.image = Discordrb::Webhooks::EmbedImage.new(url: url)
              embed.footer = {text: "par #{event.user.name}" }
            end
	    event.message.delete
	  else
	    event.respond("Cet emoji n'est pas (encore) possible à agrandir :disappointed_relieved: ")
	  end
	end

	return
      end
    end
  end
end
