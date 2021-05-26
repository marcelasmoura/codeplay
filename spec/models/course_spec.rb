require 'rails_helper'

describe Course do

  let!(:teacher) do
    Teacher.create!(name: 'Amanda', bio: 'Professora de Ingles',
                   email: 'abr@email.com',
                   profile_picture: {io: File.open(Rails.root.join('spec', 'fixtures', 'profile.jpeg')),
                   filename: 'profile.jpeg'})
  end

  context 'validation' do
    it 'attributes cannot be blank' do
      course = Course.new

      course.valid?

      expect(course.errors[:name]).to include('não pode ficar em branco')
      expect(course.errors[:code]).to include('não pode ficar em branco')
      expect(course.errors[:price]).to include('não pode ficar em branco')
    end

    it 'code must be uniq' do

      Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                    code: 'RUBYBASIC', price: 10,
                    enrollment_deadline: '22/12/2033', teacher: teacher)
      course = Course.new(code: 'RUBYBASIC')

      course.valid?

      expect(course.errors[:code]).to include('já está em uso')
    end
  end
end
