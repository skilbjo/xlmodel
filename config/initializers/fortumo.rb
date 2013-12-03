Rails.configuration.fortumo = {
  :secret_key      => ENV['FORTUMO_SECRET_KEY']
}

Fortumo_secret = Rails.configuration.fortumo[:secret_key]


#Fortumo_secret = ENV['FORTUMO_SECRET_KEY']