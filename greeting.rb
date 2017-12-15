
greeting = ARGV[0]

ARGV[1..-1].each do |arg|
  puts "#{greeting} #{arg}"
end
  