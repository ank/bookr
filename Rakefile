require "fileutils"
require "amazon/ecs"

load 'environment.rb'

STDOUT.sync = true
DEBUG = false

desc 'reset'
task :reset do
  `ruby schema.rb`
end

desc 'reload'
task :reload => :reset do
  print "Reloading."
  ['pdf', 'chm'].each do |type|
    books = Dir.glob('/path/to/books/**/*.' + type)
    
    books.each do |f|
      
      records = DB[:books]
      basename, ext = File.basename(f), File.extname(f)
      basename.sub!(ext,'')
      
      ext.sub!(".",'')      
 
      records.insert(
      :name => basename,
      :ext => ext,
      :path => File.path(f),
      :created_at => Time.now,
      :updated_at => Time.now
      )
      puts f if DEBUG
    end
    print "."
  end
end

desc 'rescan using Amazon'
task :rescan do
  ['pdf', 'chm'].each do |type|
    books = Dir.glob('/path/to/books/**/*.' + type)

    books.each do |f|
      path = clean(f)
      puts path if DEBUG
      items = fetch_items(path)

      if items
        title = items.first.get('itemattributes/title')
        detailpageurl = items.first.get('detailpageurl')
        asin =  items.first.get('asin')

        book = DB[:books].filter(:path => f)
        
        book.update(
        :title => title,
        :detailpageurl => detailpageurl,
        :asin => asin,
        :updated_at => Time.now
        )
        puts "+ #{title}"
      else
        puts "- ";
      end
      sleep 1
    end
  end
end

task :fetch do
  type = "pdf"
  books = Dir.glob('/path/to/books/**/*.' + type)
  item = fetch_item(clean(books[100]))
  puts item.get('itemattributes/title')
  puts item.get('detailpageurl')
end

def fetch_items(name)
  begin
    Amazon::Ecs.options = {:aWS_access_key_id => ENV['AWS_ACCESS_KEY_ID']}
     res = Amazon::Ecs.item_search(name)
     if res.is_valid_request?
       p res if DEBUG
       if res.items.size > 0
         return res.items
       else
         return nil
       end
     else
       sleep 5 #invalid request; maybe 503?
       return nil
     end
  rescue Exception => e
    return nil
  end
end

def clean(filename)
  base, ext = File.basename(filename), File.extname(filename)
  base.sub!(ext, "")
  base.gsub!(/[._]/," ")
  base.gsub!(/\d\d\d\d/,"")
  base.gsub!(/[\W]/," ")
  base = base[0..30]
  return base
end
  
desc 'migrate the database'
task :migrate do

end


