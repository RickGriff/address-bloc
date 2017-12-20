require_relative "../models/address_book"

RSpec.describe AddressBook do
  
  describe "attributes" do
    it "responds to entries" do
      book = AddressBook.new
      expect(book).to respond_to(:entries)
    end
    
    it "initializes entries as an array" do
      book = AddressBook.new
      expect(book.entries).to be_an(Array)
    end
    
    it "initializes entries as empty" do
      book = AddressBook.new
      expect(book.entries.size).to eq(0)
    end
  end
    
  describe "#add_entry" do
    it "adds only one entry to the address book" do
      book = AddressBook.new
      book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
      
      expect(book.entries.size).to eq(1)
    end
    
    it "adds the correct information to entries"  do
      book = AddressBook.new
      book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
      new_entry = book.entries[0]
      
      expect(new_entry.name).to eq('Ada Lovelace')
      expect(new_entry.phone_number).to eq('010.012.1815')
      expect(new_entry.email).to eq('augusta.king@lovelace.com')
    end
  end
  
  describe "#remove_entry" do
    it "removes one entry from the Address Book" do
      book = AddressBook.new
      book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
      book.add_entry('John Doe', '123.456.7889', 'john.doe@gmail.com')
      book.remove_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
      
      expect(book.entries.size).to eq(1)
    end
      
      
    it "removes the correct entry from the book and doesn't remove others" do
      book = AddressBook.new
      book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
      book.add_entry('John Doe', '123.456.7889', 'john.doe@gmail.com')
      book.remove_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
  
      #check that the other entry is still there
      expect(book.entries[0].name).to eq('John Doe')
      expect(book.entries[0].phone_number).to eq('123.456.7889')
      expect(book.entries[0].email).to eq('john.doe@gmail.com')
      
      #check the correct entry has been removed
      found = false
      book.entries.each do |entry|
        if entry.name == 'Ada Lovelace'
          found == true
        end
      end
      
      expect(found).to eq(false)
    end
  end
end