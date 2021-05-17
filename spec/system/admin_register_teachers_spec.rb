require 'rails_helper'

describe 'Admin registers teachers' do
  it 'from index page' do
    visit root_path
    click_on 'Professores'

      expect(page).to have_link('Registrar um Professor',
                            href: new_teacher_path)
  end

  it 'successfully' do
    visit root_path
    click_on 'Professores'
    click_on 'Registrar um Professor'

    fill_in 'Nome*', with: 'Rafael Silva'
    fill_in 'E-mail*', with: 'rf@email.com'
    fill_in 'Descrição', with: 'Trabalho com ruby a 10 anos.'
    attach_file 'Foto do Perfil', Rails.root.join('spec', 'fixtures', 'img.svg')
    click_on 'Cadastrar Professor'

    expect(current_path).to eq(teacher_path(Teacher.last))
    expect(page).to have_content('Rafael Silva')
    expect(page).to have_content('rf@email.com')
    expect(page).to have_content('Trabalho com ruby a 10 anos.')
    expect(page).to have_css('img.profile-picture')
    expect(page).to have_link('Voltar')
  end

  it 'a fill is empty' do
    visit root_path
    click_on 'Professores'
    click_on 'Registrar um Professor'

    fill_in 'Nome*', with: ''
    fill_in 'E-mail*', with: 'abr@email.com'
    fill_in 'Descrição', with: 'História'
    attach_file 'Foto do Perfil', Rails.root.join('spec', 'fixtures', 'img.svg')
    click_on 'Cadastrar Professor'

    expect(page).to have_content('Você deve informar os campos obrigatórios')
  end

  it 'edit a teacher resgister' do
    visit root_path
    click_on 'Professores'
    click_on 'Registrar um Professor'

    fill_in 'Nome*', with: 'Abr'
    fill_in 'E-mail*', with: 'abr@email.com'
    fill_in 'Descrição', with: 'História'
    attach_file 'Foto do Perfil', Rails.root.join('spec', 'fixtures', 'img.svg') #rspe de active storage recebendo img
    click_on 'Cadastrar Professor'

    click_on 'Editar'

    fill_in 'Nome*', with: 'Abraão'
    click_on 'Atualizar dados'
  end

  it 'is a email uniq' do

    Teacher.create!(name: 'Amanda', bio: 'Professora de Ingles',
                   email: 'abr@email.com',
                   profile_picture: {io: File.open(Rails.root.join('spec', 'fixtures', 'img.svg')),
                    filename: 'img.svg'})
    
    visit root_path
    click_on 'Professores'
    click_on 'Registrar um Professor'

    fill_in 'Nome*', with: 'Abr'
    fill_in 'E-mail*', with: 'abr@email.com'
    fill_in 'Descrição', with: 'História'
    attach_file 'Foto do Perfil', Rails.root.join('spec', 'fixtures', 'img.svg') #rspe de active storage recebendo img
    click_on 'Cadastrar Professor'

    expect(page).to have_content('E-mail já cadastrado!')    
  end
end
