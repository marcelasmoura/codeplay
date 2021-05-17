require 'rails_helper'

describe Teacher do
  context 'validation' do
    it 'attributes cannot be blank' do
      teacher = Teacher.new

      teacher.valid?

      expect(teacher.errors[:name]).to include('Você deve informar os campos obrigatórios')
      expect(teacher.errors[:email]).to include('Você deve informar os campos obrigatórios')
    end

    it 'code must be uniq' do
      Teacher.create!(name: 'Ana', email:'r@email.com',
                    bio: 'Prof de história')
      teacher = Teacher.new(email: 'r@email.com')

      teacher.valid?

      expect(teacher.errors[:email]).to include('E-mail já cadastrado!')
    end

    it 'should attach a profile picture' do
      teacher = Teacher.create(
        name: 'Joana',
        email: 'jo@email.com',
        bio: 'Inspirado em Joana D\'arq',
        profile_picture: {
          io: File.open(Rails.root.join('spec', 'fixtures', 'img.svg')),
          filename: 'img.svg'
        })
      
      expect(teacher.profile_picture).to be_attached
    end
  end
end
