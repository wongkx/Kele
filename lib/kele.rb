require 'httparty'

class Kele
    include HTTParty

    def initialize(e, p)
        auth = { "email": e, "password": p }.to_json
        
        headers = { :content_type => 'application/json'}
        
        response = self.class.post('https://www.bloc.io/api/v1/sessions', {:body => auth, :headers => headers} )

        @auth_token = response["auth_token"]
        puts response
        puts @auth_token
    end
end