require_relative 'book'
require_relative 'person'

class Rental
  attr_accessor :date, :book, :person, :id

  def initialize(id, date, book, person)
    @date = date
    @person = person
    @book = book
    @id = id
    # @book.rentals << self
    # @person.rentals << self
  end
end
