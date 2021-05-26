require 'rails_helper'

describe Teacher do
  context 'validation' do
    it 'attributes cannot be blank' do
      teacher = Teacher.new

      teacher.valid?

      expect(teacher.errors[:name]).to include('não pode ficar em branco')
      expect(teacher.errors[:email]).to include('não pode ficar em branco')
    end

    it 'code must be uniq' do
      Teacher.create!(name: 'Ana', email:'r@email.com',
                    bio: 'Prof de história')
      teacher = Teacher.new(email: 'r@email.com')

      teacher.valid?

      expect(teacher.errors[:email]).to include('já está em uso')
    end

    it 'should attach a profile picture' do
      teacher = Teacher.create(
        name: 'Joana',
        email: 'jo@email.com',
        bio: 'Inspirado em Joana D\'arq',
        profile_picture: {
          io: File.open(Rails.root.join('spec', 'fixtures', 'profile.jpeg')),
          filename: 'profile.jpeg'
        })
      
      expect(teacher.profile_picture).to be_attached
    end
  end
end
