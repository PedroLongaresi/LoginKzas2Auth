require "capybara"
require "capybara/rspec"
require "selenium-webdriver"
require_relative "ConnectMysql"
require_relative "apoio/ObjectPartner"
list= BotoesECss()

describe "Sistema de Login", :testelogin do
    before(:each) do
        visit "https://devcc.kzas.com.br/login"
        puts "Dois"
    end

    it "Senha Errada" do      
        expect(page.title).to eql "Kzas | Central"
        fill_in list[:mail], with: 'pedro@kzas.ai'
        fill_in 'password', with: '1234567' #FAKEPASSWORD
        click_button 'Acessar'
        sleep 1
        find(:css, '.swal-title').text eq('Erro')
        find(:css, '.swal-text').text eq('Login inválido!')
        sleep 1
        click_button 'OK'

    end

    it "Senha Correta com Codigo Errado" do
        expect(page.title).to eql "Kzas | Central"
        fill_in list[:mail], with: 'pedro@kzas.ai'
        fill_in 'password', with: '123456' #FAKEPASSWORD
        click_button 'Acessar'
        sleep 1
        find(:css, '.swal-text').text eq('Por favor, informe o token enviado para seu whatsapp')
        find(:css, '.swal-content__input').send_keys('123456')
        click_button 'VALIDAR'
        sleep 2
        find(:css, '.swal-title').text eql('Erro')
        find(:css, '.swal-text').text eql('Não foi possível validar seu token!')
        click_button 'OK'

    end

    it "Login correto" do
        expect(page.title).to eql "Kzas | Central"
        fill_in list[:mail], with: 'pedro@kzas.ai'
        fill_in 'password', with: '123456' #FAKEPASSWORD
        click_button 'Acessar'
        sleep 2
        find(:css, '.swal-text').text eq('Por favor, informe o token enviado para seu whatsapp')
        cod = connectBancoDados("+5516980")  
        find(:css, '.swal-content__input').send_keys(cod[0])
        sleep 1
        click_button 'VALIDAR'
        sleep 5
        expect(page).to have_no_css("")
        find(:css, '.title').text eq('Clientes')
        expect(find(:css, '.title')).to have_content 'Clientes'
        sleep 2
    end

end
