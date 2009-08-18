require "sequel"
require "logger"

ROOT = "/mnt/arr/eBooks"
DB = Sequel.connect("postgres://kraut:sqlKRAUT@localhost/books")
DB.loggers << Logger.new($stdout)
Sequel.extension :pagination