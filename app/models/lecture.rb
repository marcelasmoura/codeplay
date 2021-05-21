class Lecture < ApplicationRecord
  belongs_to :course

  validates :issue, :date, presence: {message: 'não pode estar vazio.'}
end
