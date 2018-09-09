require 'httparty'
require 'json'
require './lib/roadmap'
require './lib/messages'

class Kele
  include HTTParty
  include Roadmap
  include Messages

  # Creates a new Kele client authorized with a username and password
  # Params: username = string, password = string
  def initialize(email, password)

    # Bloc's API URL
    # Params: endpoint = string
    def api_url(endpoint)
      "https://www.bloc.io/api/v1/#{endpoint}"
    end

    # Use the httparty class method .post to send a post request to the sessions endpoint of Bloc’s API with the email and password in the body of the request.
    response = self.class.post(api_url("sessions"), body: {"email": email, "password": password})

    # The @auth_token instance variable holds the authorization token provided by Bloc's API upon verifying successful username and password.
    @auth_token = response["auth_token"]

    # If the username and password are invalid, Bloc's API will not return an authorization token.
    puts "There was a problem authorizing those credentials. Please try again." if @auth_token.nil?
  end


  # Retrieve's the current user as a JSON blob by passing auth_token to the request to property authenticate against the Bloc API.
  # Params: auth_token = string
  # Use the httparty class method .get to pass the auth_token to Bloc's API with httparty's header option.
  def get_me
    response = self.class.get(api_url("users/me"),
    headers: { "authorization" => @auth_token })

    # Parse the JSON document returned in the response into a Ruby hash
    JSON.parse(body.response)
  end

  #Retrieve the availability of the current user’s mentor
  def get_mentor_availability(mentor_id)
    # Point the HTTParty GET method at the mentors/mentor_id/student_availability endpoint of Bloc’s API.
    # Use HTTParty’s header option to pass the auth_token.
    response = self.class.get("/mentors/#{mentor_id}/student_availability", headers: { “authorization” => @auth_token })
    # This is the array that will hold all of the time slots that are not booked.
    available = []
    # Parse the JSON document returned in the response into a Ruby hash.
    # Loop through each of the mentor’s time slots. If the booked attribute is null, or the time slot is available, add that time slot to the available array.
    JSON.parse(response.body).each do |time_slot|
      if time_slot[“booked”].nil?
       available << time_slot
      end
    end
    # Return all of the available time slots.
    available
  end

end
