require_relative 'book'
require_relative 'student'
require_relative 'teacher'
require_relative 'rental'
require_relative 'list'
require 'json'
require './data'

class App < List
  attr_accessor :book_list, :people

  def initialize
    super()
    @book_list = []
    @people = []
    @rentals = []
  end


  # ======== Load books=======

  def load_books
    return unless File.exist?('./books.json')

    file = File.read('./books.json')
    data = JSON.parse(file)
    data.each do |book|
      @book_list << Book.new(book['title'], book['author'])
    end
  end

  # ========load people ========
  def load_people
    return unless File.exist?('./people.json')

    file = File.read('./people.json')
    data = JSON.parse(file)
    data.each do |person|
      @people <<
        if person['parent_permission']
          Student.new(person['age'], person['name'], parent_permission: person['parent_permission'])
        else
          Teacher.new(person['age'], person['specialization'], person['name'])
        end
    end
  end

  # =======Load retals =========
  def load_rentals
    return unless File.exist?('./rentals.json')

    file = File.read('./rentals.json')
    data = JSON.parse(file)
    data.each do |rental|
      @rentals << Rental.new(rental['date'], @people.select do |person|
                                               person.name == rental['person']
                                             end.first, @book_list.select do |book|
                                                          book.title == rental['book']
                                                        end.first)
    end
  end
end
