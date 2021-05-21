class Course < ApplicationRecord
	belongs_to :teacher
	has_many :lectures
	validates :name, :code, :price, presence: {message: 'não pode ficar em branco'}

	validates  :code, uniqueness: {message: 'já está em uso'}
end
