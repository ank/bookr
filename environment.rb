require "sequel"
require "logger"

# Connection string
DB_URI = "postgres://user:password@host/books"
BOOK_DIR="/path/to/books/**/*."

# Open a database
DB = Sequel.connect(DB_URI)

DB.loggers << Logger.new($stdout)
