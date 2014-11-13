set :stage, :production

server '104.236.17.147', user: 'deploy', roles: %w{web app}
