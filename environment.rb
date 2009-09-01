require "sequel"
require "logger"

ROOT = "/path/to/books"

# Open a database
DB = Sequel.connect("postgres://user:password@host/books")

DB.loggers << Logger.new($stdout)

#Sequel.extension :pagination
