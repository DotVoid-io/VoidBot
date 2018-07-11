module VoidBot

  # Module for permissions
  module Permissions

    def self.set!
      # Roles
      BOT.set_role_permission(455635293492477962, 100) # Admin => 100
      
      # Users
      #BOT.set_user_permission(456845128116469790, 100) # triinoxys => 100
    end
  end
end

