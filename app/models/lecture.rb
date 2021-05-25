class Lecture < ApplicationRecord
  belongs_to :course

  validates :issue, :date, presence: true
end
