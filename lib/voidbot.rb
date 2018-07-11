require 'uri'
require 'yaml'
require 'fileutils'
require 'open-uri'
require 'json'
require 'twemoji'

# Gems.
require 'bundler/setup'

Bundler.require(:default)


# Methods that should be accessible everywhere.
module Kernel

  # Runs a block without warning messages
  def no_warning(&block)
    original_verbosity = $VERBOSE
    $VERBOSE = nil
    yield block
    $VERBOSE = original_verbosity
  end

  # Converts seconds to human readable format.
  def time_in_words(time)
    days = (time / 86_400).to_i
    time -= days * 86_400
    hours = (time / 3600).to_i
    time -= hours * 3600
    minutes = (time / 60).to_i
    string = "#{days} jour#{'s' unless days == 1},"
    string << " #{hours} heure#{'s' unless hours == 1},"
    string << " #{minutes} minute#{'s' unless minutes == 1}"
  end

  # Converts boolean values to more appealing format.
  # Possible modes: on, enabled.
  def bool_to_words(bool, mode = :on)
    case mode
    when :on
      string_if_true = 'on'
      string_if_false = 'off'
    when :enabled
      string_if_true = 'enabled'
      string_if_false = 'disabled'
    else
      raise ArgumentError
    end

    return string_if_true if bool
    string_if_false
  end

  # Returns true if specified url string is valid.
  def valid_url?(url)
    uri = URI.parse(url)
    return true if uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
    false
  rescue
    false
  end

  # Returns urls host.
  def url_host(url)
    URI.parse(url).host
  rescue
    nil
  end

  # Generates a random string with default length of 10.
  def rand_string(length = 10)
    rand(36**length).to_s(36)
  end
end


# Base module for VoidBot.
module VoidBot
  require_relative 'voidbot/config'

  CONFIG = Config.new
  LOGGER = Discordrb::LOGGER
  no_warning { Discordrb::LOG_TIMESTAMP_FORMAT = '%d-%m-%Y %H:%M:%S' }

  Dir["#{File.dirname(__FILE__)}/voidbot/*.rb"].each { |file| require file }

  BOT = Discordrb::Commands::CommandBot.new(token: CONFIG.token,
                                            application_id: CONFIG.client_id,
                                            prefix: CONFIG.prefix,
                                            advanced_functionality: false,
                                            fancy_log: true,
					    command_doesnt_exist_message: "Cette commande n'existe pas <:nothappy:449891097381044224> \nTape `#{CONFIG.prefix}help` pour un peu d'aide! :wink:",
					    no_permission_message: ":warning: <@456845128116469790> à la rescousse, je suis censé avoir cette perm! <:nothappy:449891097381044224>",
					    help_command: [:help, :aide]
       )

  # Set roles/users Permissions, define Commands and Events. 
  # See lib/voidbot/commands.rb, lib/voidbot/events.rb and lib/voidbot/permissions.rb
  Permissions.set!
  Commands.include!
  Events.include!

  at_exit do
    LOGGER.info 'Arret du bot...'
    exit!
  end

  LOGGER.info 'VoidBot | Utilisez Ctrl+C pour arreter le bot.'
  BOT.run

end
