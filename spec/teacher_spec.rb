require './teacher'

describe Teacher do
  context 'create a teacher' do
    teacher = Teacher.new( 'Ruby', 33,'John')

    it 'check the age' do
      expect(teacher.age).to eq 33
    end

    it 'check the name' do
      expect(teacher.name).to eq 'Ruby'
    end
  end
end
