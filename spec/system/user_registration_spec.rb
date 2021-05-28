require 'rails_helper'

describe 'User Registrator' do
  context 'Create a register' do
    it 'create a register with email and password' do
     visit root_path
     click_on 'Entrar'
     click_on 'Criar Conta'

     fill_in 'Email', with: 'user@email.com'
     fill_in 'Senha', with: '@1senha'
     fill_in 'Confirmação de senha', with: '@1senha'

     click_on 'Criar conta'

     expect(page).to have_text("Bem-vindo!")
     expect(page).to have_text('user@email.com')
     expect(page).to have_link('Cursos')

     visit root_path

     expect(page).to_not have_link('Entrar')
     expect(page).to have_link('Sair')
     expect(page).to have_content('user@email.com')
    end

    it 'user register a email not uniq' do
      User.create!(email: 'a@email.com', password: 'thisisapassword')
      visit root_path
      click_on 'Entrar'
      click_on 'Criar Conta'

      fill_in 'Email', with: 'a@email.com'
      fill_in 'Senha', with: 'firstpassword'
      fill_in 'Confirmação de senha', with: 'firstpassword'
      click_on 'Criar conta'

      expect(page).to have_content('Email já está em uso')
    end

    it 'password do not match with the confirmation' do
      visit root_path
      click_on 'Entrar'
      click_on 'Criar Conta'

      fill_in 'Email', with: 'a@email.com'
      fill_in 'Senha', with: 'firstpassword'
      fill_in 'Confirmação de senha', with: '12345'
      click_on 'Criar conta'

      expect(page).to have_content('Confirmação de senha não é igual a Senha')
    end
  end

  context 'User do a Login' do
    it 'successfully' do
      User.create!(email: 'a@email.com', password: 'thisisapassword')
      visit root_path
      click_on 'Entrar'

      within '.new_user' do
        fill_in 'Email', with: 'a@email.com'
        fill_in 'Senha', with: 'thisisapassword'
        click_on 'Entrar'
      end

      expect(page).to have_content("Logado com sucesso.")
      expect(page).to_not have_link('Entrar')
      expect(page).to have_link('Sair')
      expect(page).to have_content('a@email.com')
    end

    it 'user do a login with a wrong password' do
      User.create!(email: 'a@email.com', password: 'thisisapassword')
      visit root_path
      click_on 'Entrar'

      within '.new_user' do
        fill_in 'Email', with: 'a@email.com'
        fill_in 'Senha', with: '123465'
        click_on 'Entrar'
      end

      expect(page).to have_content('Email ou senha inválida.')
    end

    it 'user forgot your password' do
      #allow_any_instance_of(Devise::Mailer).to receive :reset_password_instruction
      User.create!(email: 'a@email.com', password: 'thisisapassword')
      visit root_path
      click_on 'Entrar'

      fill_in 'Email', with: 'a@email.com'
      click_on 'Esqueci minha senha'
      fill_in 'Email', with: 'a@email.com'
      click_on 'Resetar minha senha'

      expect(page).to have_content('Você receberá, em breve, um email com instruções de como redefinir sua senha.')
      mail_sent = ActionMailer::Base.deliveries[0]
      expect(mail_sent.subject).to eq('Instruções de redefinição de senha')
      expect(mail_sent.to[0]).to eq ('a@email.com')
    end
    
  end

  context 'User do a Logout' do
    it 'successfully' do
        User.create!(email: 'a@email.com', password: 'thisisapassword')
      visit root_path
      click_on 'Entrar'

      within '.new_user' do
        fill_in 'Email', with: 'a@email.com'
        fill_in 'Senha', with: 'thisisapassword'
        click_on 'Entrar'
      end
        click_on 'Sair'

      expect(page).to_not have_content('Sair')
      expect(page).to_not have_content('a@email.com')
      expect(page).to have_content('Entrar')
    end
  end
end