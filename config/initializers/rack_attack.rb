# frozen_string_literal: true

# Throttle login attempts for a given email parameter to 6 reqs/minute
# Return the email as a discriminator on POST /login requests
Rack::Attack.throttle('limit logins per username', limit: 4, period: 60) do |req|
  req.params['username'] if req.path == '/login' && req.post?
end
