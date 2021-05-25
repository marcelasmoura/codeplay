class Course < ApplicationRecord
	belongs_to :teacher
	has_many :lectures, dependent: :delete_all
	validates :name, :code, :price, presence: true
	validates  :code, uniqueness: true
end
