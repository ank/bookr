require "sequel"

ROOT = "/mnt/arr/eBooks"
DB = Sequel.connect("postgres://kraut:sqlKRAUT@localhost/books")

Sequel.extension :pagination