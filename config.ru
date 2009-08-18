require 'rubygems'
require 'sinatra'

Sinatra::Application.set(
  :run => false,
  :environment => ENV['RACK_ENV']
)

require 'server'
run Sinatra::Application