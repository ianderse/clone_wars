require 'sequel'
require 'sqlite3'

class ContentStore

	def all
	  content = database.from(:content)
	  content.select.to_a
	end

	def database
	  return @database if @database

	  @database = Sequel.sqlite('db/database.sqlite3')
	  @database
	end

	def find_content(id)
	  content = database.from(:content)
	  content.where(:id => id).to_a[0]
	end

	def content(id)
	  find_content(id)[:content]
	end

	def page(id)
	  find_content(id)[:page]
	end

	def all_products
		dataset = database.from(:products)
		dataset.select.to_a
	end

	def find_product(id)
		products = database.from(:products)
		products.where(:id => id).to_a[0]
	end

	def size(id)
		find_product(id)[:size].split(',')
	end

	def name(id)
		find_product(id)[:name]
	end

	def image(id)
		find_product(id)[:image]
	end

	def price(id)
		find_product(id)[:price].split(',')
	end

	def update(id, content)
	  database.from(:content).where(id: id).update(content: content)
	end

	def update_product(id, data)
		product = database.from(:products).where(id: id)
		product.update(size: data[:size])
		product.update(name: data[:name])
		product.update(image: data[:image])
		product.update(price: data[:price])
	end

	def create_review(user_name,review)
		reviews = database.from(:reviews)
		reviews.insert(:name => user_name, :review => review)
	end

	def all_reviews
		dataset = database.from(:reviews)
		dataset.select.to_a
	end

end
