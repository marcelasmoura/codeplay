class CreateTeachers < ActiveRecord::Migration[6.0]
  def change
    create_table :teachers do |t|
      t.string :name
      t.string :email
      t.text :bio
      t.string :profile_photo

      t.timestamps
    end
  end
end
