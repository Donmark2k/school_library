require_relative '../book'
require_relative '../student'
require_relative '../teacher'
require_relative '../rental'
require 'json'

class Loader
  attr_accessor :books, :people, :rentals

  def initialize
    super()
    @books = []
    @people = []
    @rentals = []
  end


  # ======== Load books=======

  def load_books
    return unless File.exist?('./data/books.json')

    file = File.read('./data/books.json')
    data = JSON.parse(file)
    data.each do |book|
      @books << Book.new(book['title'], book['author'])
    end
  end

  # ========load people ========

  def load_people
    return unless File.exist?('./data/people.json')

    file = File.read('./data/people.json')
    data = JSON.parse(file)
    data.each do |person|
      if person['parent_permission']
        student = Student.new(person['age'], person['name'], parent_permission: person['parent_permission'])
        @people << student
      else
        teacher = Teacher.new(person['name'], person['age'], person['specialization'])
        teacher.id = person['id'] # Set the id of the teacher object
        @people << teacher
      end
    end
  end

  # =======Load retals =========
  def load_rentals
    return unless File.exist?('./data/rentals.json')

    file = File.read('./data/rentals.json')
    data = JSON.parse(file)
    data.each do |rental|
      @rentals << Rental.new(rental['id'], rental['name'], rental['book'], rental['author'])
    end
  end
end
