require 'rails_helper'

describe Lecture do
  let(:teacher) do
    Teacher.create!(name: 'Amanda', bio: 'Professora de Ingles',
                   email: 'abr@email.com',
                   profile_picture: {io: File.open(Rails.root.join('spec', 'fixtures', 'img.svg')),
                   filename: 'img.svg'})
  end

  let(:course) do
    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
               code: 'RUBYBASIC', price: 10,
               enrollment_deadline: '22/12/2033', teacher: teacher)
  end

  context 'validation' do
    it 'attributes cannot be blank' do
        lecture = Lecture.new

      lecture.valid?

      expect(lecture.errors[:issue]).to include('não pode estar vazio.')
      expect(lecture.errors[:date]).to include('não pode estar vazio.')
    end
  end

  it '' do
    lect  = Lecture.new(course_id: course.id)

    expect(lect.course).to eq (course)
  end
end
