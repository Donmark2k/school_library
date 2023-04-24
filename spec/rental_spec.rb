require './rental'
require './book'
require './student'

describe Rental do
  context 'create a rental' do
    book = Book.new 'Purple_Hibiscus', 'Chiamanda'
    student = Student.new(48, 'Chukwuemeka', 'ENG121', parent_permission: true)
    rental = Rental.new('01/04/2023', book, student)

    it 'check the date' do
      rental.date.should eq '01/04/2023'
    end

    it 'show the title' do
      expect(book.title).to eq 'Purple_Hibiscus'
    end

    it 'show the author' do
      expect(book.author).to eq 'Chiamanda'
    end

    it 'show student name' do
      expect(student.name).to eq 'Chukwuemeka'
    end

    it 'show student age' do
      expect(student.age).to eq 48
    end

    it 'show classroom' do
      expect(student.classroom).to eq 'ENG121'
    end
  end
end
