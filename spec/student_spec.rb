require './student'

describe Student do
  context 'create a student' do
    student = Student.new(48, 'Chukwuemeka', 'ENG121', parent_permission: true)

    it 'show name' do
      expect(student.name).to eq 'Chukwuemeka'
    end

    it 'show classroom' do
      expect(student.classroom).to eq 'ENG121'
    end

    it 'show age' do
      expect(student.age).to eq 48
    end
  end
end
