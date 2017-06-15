require 'httparty'

class Kele
  include HTTParty

  base_uri 'https://www.bloc.io/api/v1'

  def initialize(username, password)
    @username = username
    @password = password

    response = self.class.post('/sessions', body: {email: @username, password: @password})
    puts response

    @auth_token = response['auth_token']
  end
end
