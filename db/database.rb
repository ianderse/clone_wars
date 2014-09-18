require 'sinatra'
require 'sinatra/activerecord'

db = URI.parse('postgres://ianderse@localhost/novo_coffee')

ActiveRecord::Base.establish_connection(
  :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
  :host     => db.host,
  :username => db.user,
  :password => db.password,
  :database => db.path[1..-1],
  :encoding => 'utf8'
)

class Product < ActiveRecord::Base

end
