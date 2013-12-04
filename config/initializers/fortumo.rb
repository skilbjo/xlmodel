Rails.configuration.fortumo = {
  :secret_key      => ENV['FORTUMO_SECRET_KEY']
}

Fortumo_secret = Rails.configuration.fortumo[:secret_key]