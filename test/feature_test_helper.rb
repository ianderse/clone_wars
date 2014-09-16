require 'sinatra'
require 'capybara'
require 'minitest/autorun'

require_relative '../lib/app.rb'

Capybara.app = NovoCoffeeApp

class FeatureTest < Minitest::Test
  include Capybara::DSL

end
