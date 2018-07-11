module VoidBot

  module Commands

    # Purge messages (mass delete)
    module Purge
      extend Discordrb::Commands::CommandContainer
      command([:purge, :p], description: 'Efface les N derniers messages.', min_args: 1, max_args: 1, permission_message: "Eh! T'as pas le droit de faire ça!! <:macron:449891102216945684>") do |event, n|
	  if event.user.role? 455635293492477962  
	      if n.to_i.to_s == n then event.channel.prune(n.to_i + 1)
              else event.respond(":x: Merci d'entrer un nombre de messages à supprimer.") end
	  else event.respond("Eh! T'as pas le droit de faire ça! <:macron:449891102216945684>")
	  end
	  return
      end
    end
  end
end
