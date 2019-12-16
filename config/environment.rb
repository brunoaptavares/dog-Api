# Load the Rails application.
require_relative 'application'

AppConfig = YAML::load_file('config/application.yml')

# Initialize the Rails application.
Rails.application.initialize!
