require './person'
describe Person do
  context 'create a person' do
    person = Person.new(27, 'Microverse')

    it ' show age' do
      expect(person.age).to eq 27
      expect(person.age).to be_instance_of Fixnum 

    end

    it 'show name' do
      expect(person.name).to eq 'Microverse'
    end

    it 'when the person does not have parent permission' do
      person = Person.new(16, 'James', parent_permission: false)
      expect(person.can_use_services?).to eq(false)
    end

    it 'when the person does not have parent permission but returns true if the person is above 18' do
      person = Person.new(21, 'James', parent_permission: false)
      expect(person.can_use_services?).to eq(true)
    end

    it 'when the person  have parent permission' do
      person = Person.new(26, 'James', parent_permission: true)
      expect(person.can_use_services?).to eq(true)
    end
  end
end
