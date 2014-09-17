require 'sequel'
require 'sqlite3'
require 'pry'

class ContentStore

def all
  content = database.from(:content)
  content.select.to_a
end
#
# def raw_ideas
#   database.transaction do |db|
#     db['ideas'] || []
#   end
# end

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


# def delete(position)
#   database.transaction do
#     database['ideas'].delete_at(position)
#   end
# end
#
# def find(id)
#   raw_idea = find_raw_idea(id)
#   Idea.new(raw_idea.merge("id" => id))
# end
#
# def find_raw_idea(id)
#   database.transaction do
#     database['ideas'].at(id)
#   end
# end
#
# def update(id, data)
#   database.transaction do
#     database['ideas'][id] = data
#   end
# end
#
# def create(data)
#   database.transaction do
#     database['ideas'] << data
#   end
# end
#
# def ideas_by_tag(tag)
#   all.select{|idea| idea.include_tag?(tag)}
# end
#
# def tags
#   tags = all.flat_map{|idea| idea.tags}
#   tags.uniq
# end
#
# def ideas_sorted_by_tags
#   ideas = tags.map{|tag| ideas_by_tag(tag)}
#   ideas.reduce(:+)
# end
#
# def ideas_by_keyword(keyword)
#   all.select{|idea| idea.include_keyword?(keyword)}
# end


end
