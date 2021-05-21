require 'rails_helper'

describe 'Admin manages letures' do
  let(:teacher) do
    Teacher.create!(name: 'Amanda', bio: 'Professora de Ingles',
                   email: 'abr@email.com',
                   profile_picture: {io: File.open(Rails.root.join('spec', 'fixtures', 'img.svg')),
                   filename: 'img.svg'})
  end
  let!(:course) do
    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
               code: 'RUBYBASIC', price: 10,
               enrollment_deadline: '22/12/2033', teacher: teacher)
  end

  let!(:lecture) do
    Lecture.create!(issue: 'Model', description: 'Como criar um model.', 
                date: '10/06/2032', course: course)
  end

  it 'successfully' do
    visit root_path
    click_on 'Cursos'
    click_on course.name
    click_on 'Add Aula'

    fill_in 'Assunto:', with: 'Aula 1'
    fill_in 'Descrição:', with: 'Aula de Apresentação '
    fill_in 'Data', with: '30/03/2036'
    click_on 'Criar'

    

    expect(page).to have_content('Aula 1')
    expect(page).to have_content('30/03/2036')
  end

  it 'cannot be blank' do
    visit root_path
    click_on 'Cursos'
    click_on course.name
    click_on 'Add Aula'
    click_on 'Criar'

    expect(page).to have_content('não pode estar vazio.', count: 2)
  end

  it 'can see the datails of a lecture' do
    visit root_path
    click_on 'Cursos'
    click_on course.name

    click_on lecture.issue

    expect(page).to have_content('Model')
    expect(page).to have_content('Como criar um model.')
    expect(page).to have_content('10/06/2032')
  end


  it 'can edit a lecture' do
    visit root_path
    click_on 'Cursos'
    click_on course.name
    click_on lecture.issue
    click_on 'Editar'

    fill_in 'Assunto:', with: 'Active Record'
    fill_in 'Descrição:', with: 'Como criar um CRUD!'
    fill_in 'Data da Aula:', with: '29/06/2040'

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
    click_on 'Excluir'

    expect(page).to_not have_content('Active Record')
  end
end