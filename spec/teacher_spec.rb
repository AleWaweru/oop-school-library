# spec/teacher_spec.rb

require_relative '../classes/teacher'
require_relative '../classes/person'

describe Teacher do
  subject(:teacher) { described_class.new('Math', 35, name: 'Alice') }

  describe '#initialize' do
    it 'sets specialization, age, name, and parent permission' do
      expect(teacher.specialization).to eq('Math')
      expect(teacher.age).to eq(35)
      expect(teacher.name).to eq('Alice')
      expect(teacher.parent_permission).to be(true)
    end

    it 'assigns a random ID' do
      expect(teacher.id).to be_a(Integer)
    end
  end

  describe '#can_use_services?' do
    it 'returns true' do
      expect(teacher.can_use_services?).to be(true)
    end
  end

  describe '#to_h' do
    it 'returns teacher data as a hash' do
      expected_hash = {
        type: 'Teacher',
        id: teacher.id,
        name: teacher.name,
        age: teacher.age,
        specialization: teacher.specialization
      }
      expect(teacher.to_h).to eq(expected_hash)
    end
  end
end
