require 'rails_helper'

describe 'Admin view teachers' do
  it 'successfully' do
    Teacher.create!(name: 'Amanda', bio: 'Professora de Ingles',
                   email: 'amanda@email.com',
                   profile_picture: {io: File.open(Rails.root.join('spec', 'fixtures', 'profile.jpeg')),
                    filename: 'profile.jpeg'})
    Teacher.create!(name: 'Larissa',
                   bio: 'Matematica pra criancas',
                   email: 'larissa_mat@email.com',
                   profile_picture: {io: File.open(Rails.root.join('spec', 'fixtures', 'profile.jpeg')),
                    filename: 'profile.jpeg'}) #importo uma imagem do caminho descrito entre ().

    visit root_path
    click_on 'Professores'

    expect(page).to have_content('Amanda')
    expect(page).to have_content('Professora de Ingles')
    expect(page).to have_css('img.profile-picture')
    expect(page).to have_content('Larissa')
    expect(page).to have_content('Matematica pra criancas')
    expect(page).to have_css('img.profile-picture')
  end

  it 'and view details' do
    Teacher.create!(name: 'Amanda', bio: 'Professora de Ingles',
                   email: 'amanda@email.com',
                   profile_picture: {io: File.open(Rails.root.join('spec', 'fixtures', 'profile.jpeg')),
                    filename: 'profile.jpeg'})
    Teacher.create!(name: 'Larissa',
                   bio: 'Matematica pra criancas',
                   email: 'larissa_mat@email.com',
                   profile_picture: {io: File.open(Rails.root.join('spec', 'fixtures', 'profile.jpeg')),
                    filename: 'profile.jpeg'})

    visit root_path
    click_on 'Professores'
    click_on 'Amanda'

    expect(page).to have_content('Amanda')
    expect(page).to have_content('Professora de Ingles')
    expect(page).to have_content('amanda@email.com')
    expect(page).to have_css('img.profile-picture')
    
    click_on 'Voltar'
  end
end