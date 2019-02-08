require "./bin/app.rb"
require "./lib/gothonweb/map.rb"
require "test/unit"
require "rack/test"

class MyAppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_my_default
    get '/'
    session = {}
    session[:room] = 'START'
    assert_equal(session[:room], 'START')
    #assert_equal('Hello World', last_response.body)
  end

  def test_start_game
    get '/game'
    assert last_response.ok?
    p last_response.body
    #assert last_response.ok?
    #assert last_response.body.include?("Central Corridor")
  end

end
