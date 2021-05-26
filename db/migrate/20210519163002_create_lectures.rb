class CreateLectures < ActiveRecord::Migration[6.0]
  def change
    create_table :lectures do |t|
      t.string :issue
      t.text :description
      t.date :date
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
