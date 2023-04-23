require_relative 'person'
require_relative 'decorator'
require_relative 'book'
require_relative 'rental'
require_relative 'teacher'
require_relative 'student'
require_relative 'classroom'
require_relative './data/loader'

require 'json'


class App
  def initialize
    @classrooms = []
    @books = []
    @rentals = []
    @people = []
  end

  def create_person
    person_type = person_option
    return if person_type.nil?

    print 'Name: '
    name = gets.chomp
    print 'Age: '
    age = gets.chomp

    case person_type
    when '1'
      create_student(name, age)
    when '2'
      create_teacher(name, age)
    end

  end

  def create_student(name, age)
    print 'Classroom: '
    classroom_name = gets.chomp
    print 'Has parent permission? [Y/N]: '
    parent_permission = gets.chomp.downcase == 'y'
    classroom = Classroom.new(classroom_name)
    student = Student.new(name, age, classroom,  parent_permission: parent_permission)
    @people << student
    save= []
    if File.exist?('./data/people.json')
      # Read existing data from file
      file = File.read('./data/people.json')
      save = JSON.parse(file)
    end
    
    # Append new teacher data to the array
    save << { id: student.id, name: student.name, age: student.age }
  
    # Write the updated array to the file
    File.write('./data/people.json', JSON.pretty_generate(save))
    puts 'Student created successfully'
  end


  def create_teacher(name, age)
    print 'Specialization: '
    specialization = gets.chomp
    teacher = Teacher.new(name, age, specialization)
    @people << teacher
    save = []
  
    if File.exist?('./data/people.json')
      # Read existing data from file
      file = File.read('./data/people.json')
      save = JSON.parse(file)
    end
    
    # Append new teacher data to the array
    save << { id: teacher.id, name: teacher.name, age: teacher.age, specialization: teacher.specialization }
  
    # Write the updated array to the file
    File.write('./data/people.json', JSON.generate(save))
  
    puts 'Teacher created successfully'
  end
  

  def person_option
    print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    person_type = gets.chomp
    if person_type != '1' && person_type != '2'
      puts 'Invalid option'
      return
    end
    person_type
  end

  
  def create_rental
    @loader = Loader.new
  
    create_rental_book
    book_index = gets.chomp.to_i
    puts
    create_rental_person
    person_index = gets.chomp.to_i
    puts
    print 'Enter a date: e.g 20/09/2023 '
    date = gets.chomp
    @loader.load_books
    book = @loader.books[book_index]
    if book.nil?
      puts "Invalid book index: #{book_index}"
      return
    end
    @loader.load_people
    person = @loader.people[person_index]
    if person.nil?
      puts "Invalid person index: #{person_index}"
      return
    end
    @rentals << Rental.new(date, book, person)
    save = []


    if File.exist?('./data/rentals.json')
      # Read existing data from file
      file = File.read('./data/rentals.json')
      save = JSON.parse(file)
    end
    
    # Append new teacher data to the array
    save << { id: person.id, name: person.name, book: book.title, Author: book.author }
  
    # Write the updated array to the file
    File.write('./data/rentals.json', JSON.pretty_generate(save))
  
  
    ######
    # @rentals.each do |rent|
    #   save << { date: rent.date, book: rent.book.title, person: rent.person.name }
    # end
    # save_rental = JSON.generate(save)
    # File.write('./data/rentals.json', save_rental)
    puts 'Rental created successfully'
  end
  

  def create_rental_book
    @loader = Loader.new
    @loader.load_books

    if @loader.books.empty?
      puts 'There are no books in the library to rent'
      return
    end
    puts 'Select a book from the following list by number'
    @loader.books.each_with_index do |book, index|
      puts "#{index}) Title: '#{book.title}', Author: #{book.author}"
    end
  end

  def create_rental_person
    @loader = Loader.new
    @loader.load_people
    puts 'Select a person from the following list by number (not id)'
    if @loader.people.empty?
      puts 'There are no people in the library'
      return
    end

    @loader.people.each_with_index do |person, index|
      puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  def list_rentals_for_person_id
    print 'ID of person: '
    id = gets.chomp.to_i
    puts 'Rentals:'
    @rentals.each do |rental|
      puts "Date: #{rental.date}, Book Title '#{rental.book.title}' by #{rental.book.author}" if rental.person.id == id
    end
  end

  def list_books
    @loader = Loader.new
    @loader.load_books
    if @loader.books.empty?
      puts 'There are no books in the library'
    else
      @loader.books.each do |book|
        puts "Title: #{book.title}, Author: #{book.author}".capitalize
      end
    end
  end

 
  def list_people
    @loader = Loader.new
    @loader.load_people
  
    if @loader.people.empty?
      puts 'There are no people in the library'
    else
      @loader.people.each do |person|
        if person.is_a?(Teacher) && person.specialization
          puts "[Teacher] ID: #{person.id}, Name: #{person.name}, Age: #{person.age},  Specialization: #{person.specialization}"
        else
          puts "[Student] ID: #{person.id}, Name: #{person.name}, Age: #{person.age}"
        end
      end
    end
  end
  

 
  def create_book
    print 'Title: '
    title = gets.chomp
  
    print 'Author: '
    author = gets.chomp
  
    # Read existing data from file, if any
    books_data = []
    if File.exist?('./data/books.json')
      books_data = JSON.parse(File.read('./data/books.json'))
    end
  
    # Append new book to existing data
    books_data << { title: title, author: author }
  
    # Write combined data back to file
    File.write('./data/books.json', JSON.pretty_generate(books_data))
  
    @books << Book.new(title, author)
    puts 'Book created successfully'
  end
  
end
