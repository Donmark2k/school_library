require_relative 'app'

class Refactor
  def initialize
    @app = App.new
  end

  def list_holder(option)
    case option
    when 1
      @app.list_books
    when 2
      @app.list_people
    when 3
      @app.create_person
    when 4
      @app.create_book
    when 5
      @app.create_rental
    when 6
      @app.list_rentals_for_person_id
    end
  end

  def display_selection
    puts "Please choose an option by entering a number from below:\n"
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person id'
    puts '7 - Exit'
  end
end
