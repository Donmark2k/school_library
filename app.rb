require_relative 'person'
require_relative 'decorator'
require_relative 'book'
require_relative 'rental'
require_relative 'teacher'
require_relative 'student'
require_relative 'classroom'
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
    @people.each do |person|
      save << {id:person.id, name:person.name,  age:person.age}
      save_teacher = JSON.generate(save)
      File.write('./data/people.json', save_teacher.to_s)
      puts 'Student created successfully'
    end
  end

  def create_teacher(name, age)
    print 'Specialization: '
    specialization = gets.chomp
    teacher = Teacher.new(name, age, specialization )
    @people << teacher
    save= []
    @people.each do |person|
      save << {id:person.id, name:person.name, age:person.age}
      save_teacher = JSON.generate(save)
      File.write('./data/people.json', save_teacher.to_s)
      puts 'Teacher created successfully'
    end
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
    create_rental_book
    book_index = gets.chomp.to_i
    puts
    create_rental_person
    person_index = gets.chomp.to_i
    puts
    print 'Enter a date: e.g 2022/09/28 '
    date = gets.chomp
    @rentals << Rental.new(date, @books[book_index], @people[person_index])
    save = []
    @rentals.each do |rent|
      save << { date: rent.date, book: rent.book.title, person: rent.person.name }
    end
    save_rental = JSON.generate(save)
    File.write('./data/rentals.json', save_rental)
    puts 'Rental created successfully'
  end

  def create_rental_book
    if @books.empty?
      puts 'There are no books in the library to rent'
      return
    end
    puts 'Select a book from the following list by number'
    @books.each_with_index do |book, index|
      puts "#{index}) Title: '#{book.title}', Author: #{book.author}"
    end
  end

  def create_rental_person
    puts 'Select a person from the following list by number (not id)'
    if @people.empty?
      puts 'There are no people in the library'
      return
    end

    @people.each_with_index do |person, index|
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
    if @books.empty?
      puts 'There are no books in the library'
    else
      @books.each do |book|
        puts "Title: #{book.title}, Author: #{book.author}".capitalize
      end
    end
  end

  def list_people
    if @people.empty?
      puts 'There are no people in the library'
    else
      @people.each do |person|
        puts "[#{person.class}] Name: #{person.name}, Age: #{person.age}, ID: #{person.id}"
      end
    end
  end

  def create_book
    print 'Title: '
    title = gets.chomp

    print 'Author: '
    author = gets.chomp

    @books << Book.new(title, author)
    save = []
    @books.each do |bookk|
      save << { title: bookk.title, author: bookk.author }
      save_book = JSON.generate(save)
      File.write('./data/books.json', save_book.to_s)
    end
    puts 'Book created successfully'
  end
end
