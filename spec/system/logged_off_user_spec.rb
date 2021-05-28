require 'rails_helper'

describe 'Logged off user' do
  context 'views of a user non logged can see in course' do
    let!(:teacher) do
      Teacher.create!(name: 'Amanda', bio: 'Professora de Ingles',
                    email: 'abr@email.com',
                    profile_picture: {io: File.open(Rails.root.join('spec', 'fixtures', 'profile.jpeg')),
                    filename: 'profile.jpeg'})
    end

    it 'see a courses list' do
      course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: '22/12/2033', teacher: teacher)
      visit root_path
      click_on 'Cursos'

      expect(page).to have_content('Cursos')
      expect(page).to have_link(course.name)
      expect(page).to have_content(course.description)
      expect(page).to have_content(course.price)
      expect(page).to_not have_content('Add Aula')
      expect(page).to_not have_content('Editar')
      expect(page).to_not have_content('Excluir')
    end

    it 'can see details of a course' do
      course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: '22/12/2033', teacher: teacher)
      visit root_path
      click_on 'Cursos'
      click_on 'Ruby'

      expect(page).to have_content(course.name)
      expect(page).to have_content(course.description)
      expect(page).to have_content(course.code)
      expect(page).to have_content(course.price)
      expect(page).to have_content('22/12/2033')
      expect(page).to have_content(course.teacher.name)
      expect(page).to have_content('Aulas')
      expect(page).to_not have_content('Add Aula')
      expect(page).to_not have_content('Editar')
      expect(page).to_not have_content('Excluir')
    end

    it 'see a lecture list' do
      course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: '22/12/2033', teacher: teacher)

      lecture = Lecture.create!(issue: 'Model', description: 'Como criar um model.', 
                date: '10/06/2032', course: course,
                support_materials: [{io: File.open(Rails.root.join('spec', 'fixtures', 'test_document.pdf')),
                    filename: 'test_document.pdf'}])

      visit root_path
      click_on 'Cursos'
      click_on course.name

      expect(page).to have_content('Aulas')
      expect(page).to have_link(lecture.issue)
      expect(page).to have_content('10/06/2032')
    end

    it 'can see the datails of a lecture' do
      course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: '22/12/2033', teacher: teacher)

      lecture = Lecture.create!(issue: 'Model', description: 'Como criar um model.', 
                date: '10/06/2032', course: course,
                support_materials: [{io: File.open(Rails.root.join('spec', 'fixtures', 'test_document.pdf')),
                    filename: 'test_document.pdf'}])

      visit root_path
      click_on 'Cursos'
      click_on course.name
      click_on lecture.issue

      expect(page).to have_content(lecture.issue)
      expect(page).to have_content('10/06/2032')
    end
  end

  context 'views of a user non logged can see in teacher' do
    let!(:teacher) do
      Teacher.create!(name: 'Amanda', bio: 'Professora de Ingles',
                    email: 'abr@email.com',
                    profile_picture: {io: File.open(Rails.root.join('spec', 'fixtures', 'profile.jpeg')),
                    filename: 'profile.jpeg'})
    end

    it 'see a teacher list' do
      visit root_path
      click_on 'Professores'

      expect(page).to have_content('Professores')
      expect(page).to have_content(teacher.name)
      expect(page).to have_css('img[src$="profile.jpeg"]')
    end
  end
end