require 'bundler'
require_relative '../db/database.rb'
require_relative './novo_coffee/user.rb'
require_relative './novo_coffee/content_store.rb'


Bundler.require

class NovoCoffeeApp < Sinatra::Base
  set :method_override, true
  set :root, 'lib/app'
  set :public_folder, 'public'

  not_found do
    erb :error, locals: {contents: ContentStore.new.all}
  end

  get '/' do
    content_store = ContentStore.new
  	erb :index, locals: {contents: content_store.all, products: content_store.all_products}
  end

  get '/cart' do
  	redirect '/'
  end

  get '/my-account' do
    erb :my_account, locals: {contents: ContentStore.new.all}
  end

  post '/my-account' do
    user = User.new
    content_store = ContentStore.new
    if user.valid?(params[:username], params[:password])
      erb :dashboard, locals: {contents: content_store.all, products: content_store.all_products}
      else
      erb :index
    end
  end

  get '/products/:product_id' do |product_id|
  	content_store = ContentStore.new
  	product = content_store.find_product(product_id.to_i)
  	erb :product_page, locals: {product: product, products: content_store.all_products, contents: content_store.all}
  end

  get '/product/:id/edit' do |id|
  	product = ContentStore.new.find_product(id)
    erb :edit_product, locals: {product: product, contents: ContentStore.new.all}
  end

  get '/news-events/2' do
    erb :news_events_page_two, locals: {contents: ContentStore.new.all}
  end

  get '/:id/edit' do |id|
    content = ContentStore.new.find_content(id)
    erb :edit, locals: {content: content, contents: ContentStore.new.all}
  end

  put '/:id/edit' do |id|
    content_store = ContentStore.new
  	content_store.update(id.to_i, params[:content])
  	erb :dashboard, locals: {contents: content_store.all, products: content_store.all_products}
  end

  put '/product/:id/edit' do |id|
    content_store = ContentStore.new
  	content_store.update_product(id.to_i, params[:product])
  	erb :dashboard, locals: {contents: content_store.all, products: content_store.all_products}
  end

  post '/message' do
    Pony.mail(:to => 'glenegbert1@gmail.com', :from => params[:name], :subject => 'Feedback from ' + params[:name], :body => "#{params[:name]} #{params[:phone]} #{params[:message]}")
    erb :contact_locations, locals: {email: "sent", contents: ContentStore.new.all}
  end

  post '/confirmation' do
    Pony.mail(:to => 'ssimon@wellesley.edu', :from => params[:name], :subject => 'Reservation from ' + params[:name], :body => "#{params[:name]} #{params[:date]} #{params[:time]} #{params[:party_size]} #{params[:email_address]} #{params[:phone]}")
    erb :about, locals: {email: "sent", content_store: ContentStore.new, contents: ContentStore.new.all}
  end

  post '/reviews' do
    ContentStore.new.create_review(params[:user_name], params[:review])
    redirect '/reviews'
  end

  get '/all' do
    @pdcts = Product.order("created_at DESC")
    #Product.inspect
    redirect '/new' if @pdcts.empty?
    erb :all, locals: {contents: ContentStore.new.all}
  end

  get '/new' do
    erb :new, locals: {contents: ContentStore.new.all}
  end

  post '/new' do
    @product = Product.new(params[:product])
    if @product.save
      redirect "/product/#{@product.id}"
    else
      erb :new, locals: {contents: ContentStore.new.all}
    end
  end

  get '/product/:id' do
    @product = Product.find_by_id(params[:id])
    erb :product, locals: {contents: ContentStore.new.all}
  end

  get '/:slug' do |slug|
    erb slug_to_template(slug), locals: {reviews: ContentStore.new.all_reviews, email: " ", content_store: ContentStore.new, contents: ContentStore.new.all}
  end

  def slug_to_template(slug)
    slug.gsub("-", "_").to_sym
  end

end
