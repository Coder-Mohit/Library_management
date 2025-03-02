class Book
    attr_accessor :title,:author,:year,:availability
    def initialize(title,author,year,availability=1)
        @title = title.downcase
        @author = author.downcase
        @year = year
        @availability = availability
    end
    def display
        print "Title: #@title, Author: #@author,Year: #@year\n"
    end
end

    
class Borrower
    attr_accessor :name,:contact
    def initialize(name,contact)
        @name = name.downcase
        @contact = contact.downcase
    end
    def display
        puts "Name: #@name, email: #@contact"
    end
end

class Library
    attr_accessor :name,:title,:returnDate
    def initialize(title,name,returnDate)
        @title = title
        @name = name
        @returnDate = returnDate
    end
    def display
        puts "Title: #@title, Borrower Name: #@name, Return Date: #@returnDate"
    end
end

arr = [Book.new("harry","john",2021),
       Book.new("ronny","hanry",2025),
       Book.new("united","tomy",2003),
      ]
borrowers = [Borrower.new("mohit","mohit@gmail.com"),
            Borrower.new("john","john@gmail.com") ]
borrowedBooks = []

def addBook(arr)
    print "enter book title : "
    title = gets.chomp
    print "enter book author : "
    author = gets.chomp
    print "enter publication year: "
    year = gets.chomp
    obj = Book.new(title,author,year,1)
    arr.push(obj)  
    print "Book added successfully\n"
end

def addBorrower
    print "Enter borrower name : "
    name = gets.chomp
    print "Enter contact information : "
    contact = gets.chomp
    obj = Borrower.new(name,contact)
    puts "Borrower added successfully!\n"
end

def searchBook(arr)
    print "Enter Book title to search : "
    title = gets.chomp.downcase
    obj = arr.select {|e| e.title == title}
    puts "#{obj.length!=0?'Search Results : ':'sorry,Book is not available!'}\n" 
    obj[0].display
end

def checkAvailability(arr,title)
    arr.select {|e| e.title==title}
end

def manageBorrowing(arr,borrowedBooks,borrowers)
    print "Enter Book Title: "
    title = gets.chomp.downcase
    print "Enter borrower name: "
    name = gets.chomp.downcase
    print "Enter return date (YYYY-MM-DD): "
    returnDate = gets.chomp
    borrower = borrowers.select {|e| e.name==name} 
    a = checkAvailability(arr,title)
    if(borrower.length==0)
        return puts "Please register borrower first!\n"
    elsif(a.length==0)
        return puts "sorry this book is not available!\n"
    else
        a[0].availability = 0
        borrowedBook = Library.new(title,name,returnDate)
        borrowedBooks.push(borrowedBook)
        puts "Book checked out successfully!\n"
    end
end

def overdueBooks(borrowedBooks)
    p "Overdue Books:"
    borrowedBooks.each do |e|
        diff = (Time.new(*e.returnDate.split("-").map(&:to_i))-Time.now)/(60 * 60 * 24)
        if(diff<=0)
            e.display
        end
    end
end

def reports(arr,borrowedBooks)
    puts "Available Books:"
    arr.each do |aBook|
        if(aBook.availability==1)
            aBook.display
        end
    end
    puts "Borrowed Books:"
    borrowedBooks.each do |bBook|
            bBook.display
    end
end
    
def returnBook(borrowedBooks,arr)
    print "Enter Book title to return book: "
    title = gets.chomp
    obj = borrowedBooks.select {|e| e.title == title }
    if (obj.length!=0)
        arr.each {|e| (e.title==title)?e.availability=1:nil}
        borrowedBooks.delete(obj[0])
        puts "Book returned successfully\n"
    else
        puts "Wrong book title\n"
    end
end

def listBorrowers(borrowers)
    puts "\nList of Borrowers"
    borrowers.each {|e| e.display  }
end

while(1)
    print "\nadd book = 1, add Borrower = 2, search book = 3, borrow book = 4\ncheck overdue books = 5, return book = 6, reports = 7, list Borrowers = 8, exit = 9 \n"
    print "please enter your choice : "
    c = gets.chomp
    case c
        when "1" then addBook(arr)
        when "2" then addBorrower
        when "3" then searchBook(arr)
        when "4" then manageBorrowing(arr,borrowedBooks,borrowers)
        when "5" then overdueBooks(borrowedBooks)
        when "6" then returnBook(borrowedBooks,arr)
        when "7" then reports(arr,borrowedBooks)
        when "8" then listBorrowers(borrowers)
        when "9" then return puts "you logged out"
        else puts "wrong key pressed"
    end 
end