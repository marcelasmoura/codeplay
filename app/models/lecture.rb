class Lecture < ApplicationRecord
  belongs_to :course

  validates :issue, :date, presence: true

  has_many_attached :support_materials

  has_rich_text :description
end
