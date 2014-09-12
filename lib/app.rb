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
  	#{}"test"
  	erb :index
  end

  get '/cart' do
  	"test"
  end

  get '/myaccount' do
  	"test"
  end

  get '/products/:product_id' do
  	"test"
  end

  get '/shop' do
  	"test"
  end

  get '/wholesale' do
  	"test"
  end

  get '/news-events' do
  	"test"
  end

  get '/about' do
  	"test"
  end

  get '/contact-locations' do
  	"test"
  end

  get '/retail-cuppings' do
  	"test"
  end

  get '/subscriptions' do
  	"test"
  end

  get '/espresso-novo' do
  	"test"
  end


end
