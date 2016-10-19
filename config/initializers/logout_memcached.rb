# initialize the dalli client for memcached logouts db
# this port should be set in configuration and tied to whatever task ensures memcached is running..
Rails.application.config.logout_memcached_client = Dalli::Client.new('localhost:11211', { namespace: "netjam/#{Rails.env}/jwt_logouts", compress: true })
