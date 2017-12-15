def hello_world
 # #1
   ARGV.each do |arg|
     puts "Hello, #{arg}!"
   end
   puts "Hello, World!"
 end

hello_world