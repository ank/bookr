load '../environment.rb'

DB.alter_table(:books) do
  add_column :created_at, :time
  add_column :updated_at, :time
end