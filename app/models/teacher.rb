class Teacher < ApplicationRecord
	has_one_attached :profile_picture
	validates :name, :email, presence: true

	validates  :email, uniqueness: {message: 'E-mail já cadastrado!'}
end
