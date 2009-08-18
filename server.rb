APP_ROOT = File.expand_path(File.dirname(__FILE__))

require 'rubygems'
require 'sinatra'

load 'environment.rb'

Dir["#{APP_ROOT}/lib/**/*.rb"].each { |lib| require lib }

set :root, APP_ROOT

post '/search' do
  if params[:q]
    query = params[:q]
    @books = DB[:books].
    filter(:name.ilike("%#{query}%")).
    filter(:ext => "pdf").all
  elsif params[:title]
    query = params[:title]
    @books = DB[:books].
    filter(:title.ilike("%#{query}%")).
    filter(:ext => "pdf").all
  else
    error "No query"
  end
  erb :results
end

get '/show/:id' do
    @book = DB[:books].filter(:id => params[:id]).first
    erb :book
end

get '/stats' do
  @stats ||= {
    :total => DB[:books].all.count,
    :pdfs => DB[:books].filter(:ext => 'pdf').all.count,
    :chms => DB[:books].filter(:ext => 'chm').all.count
  }
  
  erb :stats
end

get '/' do
  @books = DB[:books].order(:name).
  filter(:ext => "pdf").filter(~{:asin => nil}).all
  
  erb :index
end

helpers do

  alias_method :h, :escape_html

  def file_link(path)
    file = path.sub("/mnt/arr","")
    filename = Pathname.new(file).basename
    "<a href='#{file}' target='_self'>#{filename}</a>"
  end
  
end



