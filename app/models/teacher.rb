class Teacher < ApplicationRecord
	has_one_attached :profile_picture
	validates :name, :email, presence: {message: 'Você deve informar os campos obrigatórios'}

	validates  :email, uniqueness: {message: 'E-mail já cadastrado!'}
end
