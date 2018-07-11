module VoidBot
  
  # Module for VoidBot commands.
  module Commands
    # Require files from directory
    Dir["#{File.dirname(__FILE__)}/commands/*.rb"].each { |file| require file }

    @commands = [
      About,
      Role,
      Purge,
      Poll,
#      Avatar,
#      Emoji,
#      Site,
      Idee,
#      Ah
    ]

    def self.include!
      @commands.each do |command|
       VoidBot::BOT.include!(command)
      end
    end
  end
end
