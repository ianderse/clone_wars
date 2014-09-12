require 'bundler'
require_relative './novo_coffee.rb'

Bundler.require

class NovoCoffeeApp < Sinatra::Base
  set :method_override, true
  set :root, 'lib/app'
  set :public_folder, 'public'

  not_found do
    erb :error
  end

  get '/' do
  	"test"
  	#erb :index
  end

end
