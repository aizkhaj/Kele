require 'httparty'
require 'json'
require './lib/roadmap'

class Kele
  attr_reader :auth_token
  include HTTParty
  include Roadmap

  base_uri 'https://www.bloc.io/api/v1'

  def initialize(username, password)
    @username = username
    @password = password

    response = self.class.post('/sessions', body: {email: @username, password: @password})

    @auth_token = response['auth_token']
  end

  def get_me
    response = self.class.get('/users/me', headers: { authorization: @auth_token })
    JSON.parse(response.body)
  end

  def get_mentor_availability
    mentor_id = get_me['current_enrollment']['mentor_id']
    raise 'Mentor ID is nonexistent' if mentor_id.nil?
    response = self.class.get("/mentors/#{mentor_id}/student_availability", headers: {authorization: @auth_token})
    JSON.parse(response.body)
  end

  def get_messages(page=1)
    response = self.class.get('/message_threads', headers: { authorization: @auth_token }, body: { page: page })
    JSON.parse(response.body)
  end

  def create_message(sender, recipient_id, token=nil, subject, stripped_text)
    body = {
      sender: sender,
      recipient_id: recipient_id,
      subject: subject,
      "stripped-text": stripped_text
    }
    body["token"] = token unless token.nil?
    response = self.class.post('/messages', headers: { authorization: @auth_token }, body: body)
  end
end
