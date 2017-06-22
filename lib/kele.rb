require 'httparty'
require 'json'

class Kele
  include HTTParty

  base_uri 'https://www.bloc.io/api/v1'

  def initialize(username, password)
    @username = username
    @password = password

    response = self.class.post('/sessions', body: {email: @username, password: @password})

    @auth_token = response['auth_token']
  end

  def get_me
    response = self.class.get('/users/me', headers: { authorization: @auth_token })
    # @mentor_id = response.body['current_enrollment']['mentor_id']
    JSON.parse(response.body)
  end

  def get_mentor_availability
    mentor_id = get_me['current_enrollment']['mentor_id']
    raise 'Mentor ID is nonexistent' if mentor_id.nil?
    response = self.class.get("/mentors/#{mentor_id}/student_availability", headers: {authorization: @auth_token})
    JSON.parse(response.body)
  end
end
