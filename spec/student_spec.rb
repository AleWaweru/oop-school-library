# spec/student_spec.rb

require_relative '../classes/student'
require_relative '../classes/classroom'

describe Student do
  let(:classroom) { Classroom.new('Math') }
  subject(:student) { described_class.new(15, classroom, name: 'Alice') }

  describe '#initialize' do
    it 'sets age, classroom, name, and parent permission' do
      expect(student.age).to eq(15)
      expect(student.classroom).to eq(classroom)
      expect(student.name).to eq('Alice')
      expect(student.parent_permission).to be(true)
    end

    it 'assigns a random ID' do
      expect(student.id).to be_a(Integer)
    end
  end

  describe '#classroom=' do
    it 'assigns a classroom and adds student to it' do
      new_classroom = Classroom.new('Science')
      student.classroom = new_classroom
      expect(student.classroom).to eq(new_classroom)
      expect(new_classroom.students).to include(student)
    end
  end

  describe '#play_hooky' do
    it 'returns a play hooky message' do
      expect(student.play_hooky).to eq('¯\\(ツ)/¯')
    end
  end

  describe '#to_h' do
    it 'returns student data as a hash' do
      expected_hash = {
        type: 'Student',
        id: student.id,
        name: student.name,
        age: student.age,
        parent_permission: student.parent_permission,
        classroom: student.classroom
      }
      expect(student.to_h).to eq(expected_hash)
    end
  end
end
