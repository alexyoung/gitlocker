require 'app'
require 'riot'
require 'rack/test'
require 'riot_macros'

set :environment, :test

def app; @app; end
def session ; last_request.env['rack.session'] ; end
include Rack::Test::Methods

