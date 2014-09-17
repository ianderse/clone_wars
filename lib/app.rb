require 'bundler'
require_relative './novo_coffee.rb'
require_relative './novo_coffee/user.rb'
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

  get '/my-account' do
    erb :my_account
  end

  post '/my-account' do
    user = User.new
    if user.valid?(params[:username], params[:password])
      erb :dashboard, locals: {contents: ContentStore.new.all}
      else
      erb :index
    end
  end

  get '/products/:product_id' do |product_id|
  	store = ContentStore.new
  	product = store.find_product(product_id.to_i)
  	erb :product_page, locals: {product: product}
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

  get '/:id/edit' do |id|
    content = ContentStore.new.find(id)
    erb :edit, locals: {content: content}
    # content_store = ContentStore.new
    # content_store.update(1, params[:content])
    # redirect '/'
  end

end
