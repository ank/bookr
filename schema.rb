load 'environment.rb'

DB.create_table! :books do
  primary_key :id
  String :asin
  String :name
  String :path
  String :ext
  String :title
  String :detailpageurl
  DateTime :created_at
  DateTime :updated_at
  
end

DB.create_table! :full_text do
  primary_key :id
  foreign_key :book_id
  Text :fulltext
  full_text_index :fulltext
  DateTime :updated_at
end

DB.create_table! :categories do
  primary_key :id
  Text :name
end

DB.create_table! :book_categories do
  foreign_key :book_id
  foreign_key :category_id
end

items = DB[:books] # Create a dataset

# Print out the number of records
puts "Item count: #{items.count}"
