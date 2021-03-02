require "dbi"
require 'mysql2'

def connectBancoDados(codigo)
    begin
        # Initialize connection variables.
        host = String('HOST')      #ANONIMIZADO CUIDADO PARA NAO COLOCAR E PUBLICAR
        port = String('PORTHERE')  #ANONIMIZADO CUIDADO PARA NAO COLOCAR E PUBLICAR
        database = String('DBNAMEHERE')   #ANONIMIZADO CUIDADO PARA NAO COLOCAR E PUBLICAR
        username = String('USERNAMEHERE')   #ANONIMIZADO CUIDADO PARA NAO COLOCAR E PUBLICAR
        password = String('PASSWORDHERE')   #ANONIMIZADO CUIDADO PARA NAO COLOCAR E PUBLICAR
    
        # Initialize connection object.
        client = Mysql2::Client.new(:host => host,:port => port, :username => username, :database => database, :password => password)
        # puts 'Successfully created connection to database.'
    
        # Drop previous table of same name if one exists
        row = client.query("Select lastauthenticationcode from dbre.user where phone= '+5516'").each(:as => :array)
        return row[0]
    
    # Error handling
    rescue Exception => e
        puts e.message
    
    # Cleanup
    ensure
        client.close if client
        puts 'Done.'
    end
end
