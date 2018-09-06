require 'httparty'

class Kele
  include HTTParty
  # Creates a new Kele client authorized with a username and password
  # Params: username = string, password = string
  def initialize(email, password)
  # Use the httparty class method .post to send a post request to the sessions endpoint of Bloc’s API with the email and password in the body of the request.
    response = self.class.post(api_url("sessions"), body: {"email": email, "password": password})
    # The @auth_token instance variable holds the authorization token provided by Bloc's API upon verifying successful username and password.
    @auth_token = response["auth_token"]
    # If the username and password are invalid, Bloc's API will not return an authorization token.
    puts "There was a problem authorizing those credentials. Please try again." if @auth_token.nil?
  end
  # Bloc's API URL
  # Params: endpoint = string
  def api_url(endpoint)
    "https://www.bloc.io/api/v1/#{endpoint}"
  end
end
