require 'rails_helper'

describe 'Admin manages letures', js: true do
  let(:teacher) do
    Teacher.create!(name: 'Amanda', bio: 'Professora de Ingles',
                   email: 'abr@email.com',
                   profile_picture: {io: File.open(Rails.root.join('spec', 'fixtures', 'profile.jpeg')),
                   filename: 'profile.jpeg'})
  end
  let!(:course) do
    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
               code: 'RUBYBASIC', price: 10,
               enrollment_deadline: '22/12/2033', teacher: teacher)
  end

  let!(:lecture) do
    Lecture.create!(issue: 'Model', description: 'Como criar um model.', 
                date: '10/06/2032', course: course,
                support_materials: [{io: File.open(Rails.root.join('spec', 'fixtures', 'test_document.pdf')),
                    filename: 'test_document.pdf'}])
  end

  let(:user) do
    User.create!(email: 'a@email.com', password: 'thisisapassword')
  end

  before do
    sign_in user
  end

  it 'successfully' do
    visit root_path
    click_on 'Cursos'
    click_on course.name
    click_on 'Add Aula'

    fill_in 'Assunto', with: 'Aula 1'
    find(:css, "#lecture_description").click.set('Aula de Apresentação ')
    fill_in 'Data', with: '30/03/2036'
    attach_file 'Material de Apoio', Rails.root.join('spec', 'fixtures', 'test_document.pdf')
    click_on 'Criar'

    click_on 'Aula 1'

    expect(page).to have_content('Aula 1')
    expect(page).to have_content('30/03/2036')
    expect(page).to have_content('Aula de Apresentação ')
    expect(page).to have_link('test_document.pdf')
  end

  it 'cannot be blank' do
    visit root_path
    click_on 'Cursos'
    click_on course.name
    click_on 'Add Aula'
    click_on 'Criar'

    expect(page).to have_content('não pode ficar em branco', count: 2)
  end

  it 'can see the datails of a lecture' do
    visit root_path
    click_on 'Cursos'
    click_on course.name

    click_on lecture.issue

    expect(page).to have_content('Model')
    expect(page).to have_content('Como criar um model.')
    expect(page).to have_content('10/06/2032')
    expect(page).to have_link('test_document.pdf')
  end


  it 'can edit a lecture', js: true do
    visit root_path
    click_on 'Cursos'
    click_on course.name
    click_on lecture.issue
    click_on 'Editar'

    fill_in 'Assunto', with: 'Active Record'
    find(:css, "#lecture_description").click.set('Como criar um CRUD!')
    fill_in 'Data da Aula', with: '29/06/2040'

    click_on 'Salvar'

    expect(page).to have_content('Active Record')
    expect(page).to have_content('Como criar um CRUD!')
    expect(page).to have_content('29/06/2040')
  end

  it 'can delete a lecture' do
    visit root_path
    click_on 'Cursos'
    click_on course.name
    click_on lecture.issue

    accept_alert do
      click_on 'Excluir'
    end

    expect(page).to_not have_content('Active Record')
  end
end