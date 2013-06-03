require 'yaml'
# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.

begin
  secret_token_config = YAML.load_file('config/secret_token.yml')
  secret_token = secret_token_config['secret_token']
rescue
end

OpenProject::Application.config.secret_token = if Rails.env.development? or Rails.env.test?
  ('x' * 30) # meets minimum requirement of 30 chars long
else
  ENV['SECRET_TOKEN'] || secret_token
end

if OpenProject::Application.config.secret_token.nil?
  puts "Warning: secret_token empty!"
  puts "Please set it with ENV variable 'SECRET_TOKEN' or "
  puts "run 'rake generate_secret_token'"
end
