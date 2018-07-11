module VoidBot

  module Commands

    module Ah
      extend Discordrb::Commands::CommandContainer

      command(:ah, description: 'AH!', usage: '!ah') do |event, *args|

        if args.size >= 1 && args[0] == "--noby"
          event.channel.send_file(File.new("data/emojis/ah.png"))
        else
          event.channel.send_embed do |embed|
            embed.image = Discordrb::Webhooks::EmbedImage.new(url: 'https://cdn.discordapp.com/emojis/449891074798911489.png')
            embed.footer = {text: "par #{event.user.name}" }
          end
        end
        
        event.message.delete
      end
    end
  end
end
