class Teacher < ApplicationRecord
	has_many :course, dependent: :restrict_with_error
	has_one_attached :profile_picture
	validates :name, :email, presence: true

	validates  :email, uniqueness: true
end
