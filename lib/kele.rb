require 'httparty'
require 'json'
require_relative 'roadmap'

class Kele
    include Roadmap
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
    
    def get_mentor_availability(mentor_id)
        url = "https://www.bloc.io/api/v1/mentors/" + mentor_id.to_s + "/student_availability"
        response = self.class.get(url,  headers: { "authorization" => @auth_token })
        @availability = JSON.parse(response.body)
    end
    
    def get_messages(pageNum = nil)
        url = "https://www.bloc.io/api/v1/message_threads"
        response = self.class.get(url,  headers: { "authorization" => @auth_token }, body: { "page" => pageNum.to_s })
        @messages = JSON.parse(response.body)
    end
    
    def post_message(sender_email, recipient_id, thread_token=nil, subject=nil, message)
        url = "https://www.bloc.io/api/v1/messages"
        response = self.class.post(url, body: { 
            "sender": sender_email,
            "recipient_id": recipient_id,
            "token": thread_token,
            "subject": subject,
            "stripped-text": message
        }, headers: { "authorization" => @auth_token })
        @message = JSON.parse(response.body)
    end
end