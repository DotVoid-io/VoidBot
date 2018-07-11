module VoidBot

  module Commands

    module Poll
      extend Discordrb::Commands::CommandContainer

      command(:poll, description: 'Outils de sondages.', usage: '!poll Question | réponse 1 | réponse 2 | autres réponses..', min_args: 3) do |event, *args|
#	event.message.delete

	args = args.join(' ').split('|')
	question = args[0]
	responses = args[1..args.size-1]

	if responses.size > 9
	  event.respond('Merci de ne pas entrer plus de 9 réponses.')
	  return
	end

	message = event.server.text_channels.find{ |channel| channel.id == CONFIG.polls_channel.to_i }.send_embed do |e|
          e.color = 5800090

	  desc = "🗳️ **#{question}**\n\n"
          responses.each_with_index do |response, index|
            index = index + 1 unless responses.size >= 9
            desc << "#{num_to_emoji(index)} #{response}\n"
          end

          e.description = desc
        end

	response = event.respond("Votre sondage a bien été créé! <##{CONFIG.polls_channel.to_i}>")

	Thread.new {
	  Thread.current[:discordrb_name] = 'react-delay'
	  responses.each_with_index do |r, index|
            index = index + 1 unless responses.size >= 9
	    message.react(num_to_emoji(index))
	    sleep(0.3)
	  end
	}.join

#       Thread.new {
#         Thread.current[:discordrb_name] = 'delete-delay'
#         sleep 3.5
#         response.delete
#       }.join
	
	return
      end

      
      command(:pollyn, description: 'Outils de sondages Oui/Non.', usage: '!poll Question', min_args: 1) do |event, *args|
#	event.message.delete

        question = args.join(' ')

	message = event.server.text_channels.find{ |channel| channel.id == CONFIG.polls_channel.to_i}.send_embed do |e|
          e.color = 5800090
          e.description = "🗳️ **#{question}**"
        end

	response = event.respond("Votre sondage a bien été créé! <##{CONFIG.polls_channel.to_i}>")
	
	Thread.new {
	  Thread.current[:discordrb_name] = 'react-delay'
	  p message.react("👍")
	  sleep(0.3)
	  message.react("👎")
	}.join

#       Thread.new {
#         Thread.current[:discordrb_name] = 'delete-delay'
#         sleep 3.5
#         response.delete
#       }.join

        return
      end


    end
  end
end

private
def num_to_emoji(index)
  case index
    when 0
      "0⃣"
    when 1
      "1⃣"
    when 2
      "2⃣"
    when 3
      "3⃣"
    when 4
      "4⃣"
    when 5
      "5⃣"
    when 6
      "6⃣"
    when 7
      "7⃣"
    when 8
      "8⃣"
    when 9
      "9⃣"
  end
end
