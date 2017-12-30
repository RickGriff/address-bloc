require_relative '../models/address_book'

class MenuController
  
  attr_reader :address_book
  
  def initialize
    @address_book = AddressBook.new
  end
  
  def main_menu
    puts "Main Menu - #{address_book.entries.count} entries"
    puts "1 - View all entries"
    puts "2 - Create an entry"
    puts "3 - Search for an entry"
    puts "4 - Import entries from a CSV"
    puts "5 - View Entry number n"
    puts "6 - Delete all entries"
    puts "7 - Exit"
    print "Enter your selection: "
    
    selection =gets.to_i
    puts "You picked #{selection}"

    case selection
      when 1
        system "clear"
        view_all_entries
        main_menu
      when 2
        system "clear"
        create_entry
        main_menu
      when 3
        system "clear"
        search_entries
        main_menu
      when 4
        system "clear"
        read_csv
        main_menu
      when 5
        system"clear"
        view_specific_entry
        main_menu
      when 6
        nuke_all_entries
        main_menu
      when 7
        puts "Good-bye!"
        exit(0)
      
      else 
        system "clear"
        puts "Sorry that is not a valid input"
        main_menu
    end
  end
 
  def view_all_entries
    address_book.entries.each do |entry|
      system "clear"
      puts entry.to_s    # call the custom to_s method defined in the Entry class
      
      entry_submenu(entry)
    end
  end

  def create_entry
    system "clear"
    puts "New AddressBloc Entry"
    print "Name: "
    name = gets.chomp
    print "Phone Number: "
    phone = gets.chomp
    print "Email: "
    email = gets.chomp
    
    address_book.add_entry(name, phone, email)
    
    system "clear"
    puts "New entry created"
  end
  
  def search_entries
    print "Search by name: "
    name = gets.chomp
    a_match = address_book.binary_search(name)
    system "clear"
    
    if a_match 
      puts a_match.to_s
      search_submenu(a_match)
    else
      puts "No match found for #{name}"
    end
  end
  
  def read_csv    
    #This method is used to interface between the user (via the menu), and the import_from_csv method of the AddressBook model.
      print "Enter CSV file to import: "
      file_name =gets.chomp
    
    if file_name.empty?  #check user has entered something for file_name
      system "clear"
      puts "No CSV file read"
      main_menu
    end
    
    begin
      entry_count = address_book.import_from_csv(file_name).count   #import the CSV named file_name to address_book, and initialize it's entry_count
      system "clear"
      puts "#{entry_count} new entries added from #{file_name}"
    rescue    #if no valid file name is given and an exception thrown, notify the user and get input again
      puts "#{file_name} is not a valid CSV file, please enter the name of a valid CSV file"
      read_csv
    end
  end
  
  #Assignment 20 Exercise
  def view_specific_entry
    if address_book.entries.count == 0     
      puts "The address book has no entries!" 
      puts "Press Return to go back to the main menu"
      gets.chomp
      return
    end
    
    puts "Enter the entry's number:"   
    num = gets.to_i
    
    while !address_book.entries[num-1]   #If the entry isn't in address_book, prompt user again
     puts "Please enter a valid entry number"
     num = gets.to_i
    end
    
    system "clear"
    puts "Entry number: #{num}"
    puts address_book.entries[num-1].to_s
    
    puts "Press Return to go back to the main menu"
    gets.chomp
  end
  
  def entry_submenu(entry)
    puts "n - next entry"
    puts "d - delete entry"
    puts "e - edit this entry"
    puts "m - return to main menu"
    
    selection = gets.chomp
    
    case selection 
      when "n"
        
      when "d"
        delete_entry(entry)
        
      when "e"
        edit_entry(entry)
        entry_submenu(entry)
        
      when "m"
        system "clear"
        main_menu
        
      else
        system "clear"
        puts "#{selection} is not a valid input"
        entry_submenu(entry)
    end
  end
  
  def search_submenu(entry)
    puts "\nd - delete this entry"
    puts "e - edit this entry"
    puts "m - return to the main menu"
    
    selection = gets.chomp
    
    case selection
      when "d"
        system "clear"
        delete_entry(entry)
        main_menu
      when "e"
        edit_entry(entry)
        system "clear"
        main_menu
      when "m"
        system "clear"
        main_menu
      else
        system "clear"
        puts "#{selection} is not a valid input"
        puts entry.to_s
        search_submenu(entry)
    end
  end
  
  def delete_entry(entry)
    address_book.entries.delete(entry)
    puts "#{entry.name} has been deleted"
  end
  
  def edit_entry(entry)
    print "Updated name: "
    name = gets.chomp
    print "Updated phone number: "
    phone_number = gets.chomp
    print "Updated email: "
    email = gets.chomp
     
    #update the attributes if user has provided them
    entry.name = name if !name.empty?
    entry.phone_number = phone_number if !phone_number.empty?
    entry.email = email if !email.empty?
    system "clear"
    
    puts "Updated entry:"
    puts entry
  end
  
  #Assignment 23
  def nuke_all_entries
    puts "Do you want to delete ALL the entries?"
    puts "y - Delete all entries"
    puts "n - Return to main menu"
    
    input = gets.chomp
    if input == 'y'
      count = address_book.entries.count
      address_book.entries.clear
      puts "All #{count} entries have been deleted"
      
    elsif input == 'n'
      puts "Returning to the main menu"
      main_menu
      
    else
      puts "Sorry, that wasn't a valid choice."
      nuke_all_entries
    end
  end
end
    
    