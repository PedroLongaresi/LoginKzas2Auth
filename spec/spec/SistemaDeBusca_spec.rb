require "capybara"
require "capybara/rspec"
require "selenium-webdriver"
require_relative "ConnectMysql"

describe "Sistema de Login", :testelogin do

    before(:each) do
        expect(page.title).to eql "Kzas | Central"
        fill_in 'email', with: 'pedro@kzas.ai'
        fill_in 'password', with: '123456'
        click_button 'Acessar'
        sleep 1
        cod = ConnectBancoDados("+5516991019880")  
        find(:css, '.swal-content__input').send_keys(cod[0])
        click_button 'VALIDAR'
        sleep 1
        find(:css, '.title').text eq('Dashboard')
        expect(find(:css, '.title')).to have_content 'Dashboard'
        sleep 2
    end


    it "Login correto" do
        puts "Login correto iniciado"

    end

end
