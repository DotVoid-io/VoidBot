module VoidBot

  module Commands

    module Role 
      extend Discordrb::Commands::CommandContainer

# Roles format
=begin
      roles = {
	  :backend  => {role_id: "465565304911822858", names: ["backend", "back"]},
          :frontend => {role_id: "465565337266552832", names: ["frontend", "front"]}
      }
=end
      
      command(:role, description: "Permet de t'attribuer des rôles en fonction de tes compétences <:rollsafe:449891102770724864>", usage: '!role <nom du role>') do |event, *args|
	file = File.read('/opt/ruby/discord/apps/VoidBot/data/roles.json')
        roles = JSON.parse(file)
	user = event.user
        
        # List
	if args.size == 0
	  response = "Voici la liste des roles! \n```"
	  roles.each do |role| 
	    response << " - #{role[0]}"
	    if role[1]["names"].size > 1 then response << " (alias: #{role[1]["names"].drop(1).join(', ')})" end
	    response << "\n"
	  end
	  response << "```"
	  event.respond(response)
	else
	  # Create
	  if args[0].downcase == "create"
	    if !user.role? 455635293492477962 then event.respond("Eh! Tu ne peux pas faire ça! <:nothappy:449891097381044224>") && return end
	    roles[args[1]] = {role_id: args[2], names: [args[1].downcase]}
	    File.open("/opt/ruby/discord/apps/VoidBot/data/roles.json", "w") { |f| f.write(JSON.pretty_generate(roles)) }
	    event.respond("Le role a bien été créé! :clap:")

	  # Delete	  
	  elsif args[0].downcase == "delete"
	    if !user.role? 455635293492477962 then event.respond("Eh! Tu ne peux pas faire ça! <:nothappy:449891097381044224>") && return end
	    roles.delete(args[1])
	    File.open("/opt/ruby/discord/apps/VoidBot/data/roles.json", "w") { |f| f.write(JSON.pretty_generate(roles)) }
	    event.respond("Le role a bien été supprimé <:nothappy:449891097381044224>")	  	

	  # Join
	  else
            asked_role = args.join('').downcase
            success = false
            roles.each do |role|
	      if role[1]["names"].include? asked_role
		if user.role? role[1]["role_id"]
		  user.remove_role(role[1]["role_id"])
		  event.respond("On dirait bien que t'avais pas les capacités pour ce role... <:nothappy:449891097381044224>")
                  success = true
		  break
		else
		  user.add_role(role[1]["role_id"])
		  event.respond("Hopla, je t'ai ajouté à ce groupe! :sunglasses:")
	  	  success = true                  
		  break
		end
              end
            end

            if !success then event.respond("Euh... Je ne trouve pas ce role... :thinking:")
            end
	  end  
	end
      end
    end
  end
end
