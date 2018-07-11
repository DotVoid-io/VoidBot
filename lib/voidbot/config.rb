module VoidBot
  
  # Holds VoidBot configuration.
  class Config
    require_relative 'store_data'
    include StoreData
  
    def initialize
      @file = "#{Dir.pwd}/data/config.yml"
      temp = load_file(@file)
      @config = temp if !temp.empty? && temp.is_a?(Hash)
      setup_config if @config.nil?
      create_methods
    end

    private

    def setup_config
      @config = {}

      puts 'Aucun fichier de configuration détecté. Création en cours...'
      puts 'Token: '
      @config[:token] = gets.chomp

      puts 'Client/Application ID: '
      @config[:client_id] = gets.chomp

      puts 'Prefix des commandes (default = "!")'
      @config[:prefix] = gets.chomp
      @config[:prefix] ||= '!'

      puts 'ID du salon pour les messages de bienvenue'
      @config[:welcome_channel] = gets.chomp
      
      puts 'ID du salon pour les propositions/idées'
      @config[:ideas_channel] = gets.chomp
    
      puts 'ID du salon pour les sondages (polls)'
      @config[:polls_channel] = gets.chomp
    
      save
    end

    def create_methods
      @config.keys.each do |key|
        self.class.send(:define_method, key) do
          @config[key]
        end
      end
    end

    def save
      save_to_file(@file, @config)
    end
  end
end
