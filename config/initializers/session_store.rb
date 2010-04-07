# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_gira_session',
  :secret      => '1205cdcc18ca0b1262cd5ba415ec7a8b1486ec1c761ec76e0a2a694b899873c1aad9e41837705b1855ea3351fd492bbf6701ef3d5e2b8d1ebcacf0db4b7e9def'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
