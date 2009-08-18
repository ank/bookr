APP_ROOT = File.expand_path(File.dirname(__FILE__))

require 'rubygems'
require 'sinatra'

load 'environment.rb'

Dir["#{APP_ROOT}/lib/**/*.rb"].each { |lib| require lib }

set :root, APP_ROOT

get '/show/:id' do
    @book = DB[:books].filter(:id => params[:id]).first
    erb :book
end

get '/search/:queury' do
  query = params[:query].to_s
  @books = DB[:books].filter(:name.like(query))
  erb :results
end

get '/about' do
  'Here is some info'
end

get '/' do
  @books = DB[:books].all
  erb :index
end

helpers do

  alias_method :h, :escape_html

  def file_link(file)
    file = file.sub("/mnr/arr/")
    filename = Pathname.new(file).basename
    "<li><a href='#{file}' target='_self'>#{filename}</a></li>"
  end

end



