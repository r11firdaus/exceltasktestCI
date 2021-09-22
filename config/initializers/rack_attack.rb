# Throttle login attempts for a given email parameter to 6 reqs/minute
# Return the email as a discriminator on POST /login requests
Rack::Attack.throttle('limit logins per username', limit: 4, period: 60) do |req|
  if req.path == '/login' && req.post?
    req.params['username']
  end
end