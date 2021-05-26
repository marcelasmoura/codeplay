require 'rails_helper'

describe 'User Registrator' do
  context 'Create a register' do
    it 'create a register with email and password' do
     visit root_path
     click_on 'Registrar-se'

     fill_in 'Email', with: 'user@email.com'
     fill_in 'Senha', with: '@1senha'

     click_on 'Criar conta'

     expect(page).to have_text('Login com sucesso')
     expect(page).to have_text('user@email.com')
     expect(page).to have_link('Cursos')

     visit root_path

     expect(page).to_not have_link('Registrar-se')
     expect(page).to have_link('Sair')
    end

    it 'user register a email not uniq' do

    end

    it 'password do not match with the confirmation' do

    end
  end

  context 'User do a Login' do
    it 'successfully' do
    end

    it 'user do a login with a wrong password' do

    end
    
  end

  context 'User do a Logout' do
    it 'successfully' do
      
    end

  end


end