require 'bundler'
require_relative './novo_coffee.rb'
require_relative './novo_coffee/content_store.rb'

Bundler.require

class NovoCoffeeApp < Sinatra::Base
  set :method_override, true
  set :root, 'lib/app'
  set :public_folder, 'public'

  not_found do
    erb :error
  end

  get '/' do
  	erb :index
  end

  get '/cart' do
  	"test" #this may or may not be its own page
  end

  post '/my-account' do
  	erb :shop, locals: {username: params[username], password: params[password]}
  end

  get '/products/:product_id' do
  	"test"
  end

  get '/news-events/2' do
    erb :news_events_page_two
  end

  get '/:slug' do |slug|
    erb slug_to_template(slug), locals: {content_store: ContentStore.new}
  end

  def slug_to_template(slug)
    slug.gsub("-", "_").to_sym
  end
end
