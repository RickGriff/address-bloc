class AddressBook
  
  require_relative 'entry'
  
  attr_reader :entries
  
  def initialize
    @entries = []
  end
  
  def add_entry(name, phone_number, email)
    
    #the following loop inserts the entry in the correct place according to
    #it's alphabetical position
    
    index = 0
    entries.each do |entry|
      
      if name < entry.name
        break
      end
      index+= 1
    end
    
    entries.insert(index, Entry.new(name,phone_number,email))
  end
  
  def remove_entry(name, phone_number, email)
    index = 0
    
    entries.each do |entry|
      if entry.name == name
        break
      end
      index+= 1
    end
    
    entries.delete_at(index)
  end
end


