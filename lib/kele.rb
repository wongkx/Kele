require 'httparty'
require 'json'

class Kele
    include HTTParty

    def initialize(e, p)
        auth = { "email": e, "password": p }.to_json
        headers = { :content_type => 'application/json'}
        response = self.class.post('https://www.bloc.io/api/v1/sessions', {:body => auth, :headers => headers} )
        @auth_token = response["auth_token"]
    end
    
    def get_me
        response = self.class.get('https://www.bloc.io/api/v1/users/me', headers: { "authorization" => @auth_token })
        @user_hash = JSON.parse(response.body)
    end
end