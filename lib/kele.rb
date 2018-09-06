require 'httparty'
require 'json'

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

  # Retrieve's the current user as a JSON blob by passing auth_token to the request to property authenticate against the Bloc API.
  # Params: auth_token = string
  # Use the httparty class method .get to pass the auth_token to Bloc's API with httparty's header option.
  def get_me
    response = self.class.get(url, headers: { "authorization" => @auth_token })
    # Parse the JSON document returned in the response into a Ruby hash
    JSON.parse(body.response)
  end
end
