module Messages
  def get_messages
  end

  def create_message
      # Point the HTTParty POST method at the messages endpoint of Bloc’s API.
      # Use HTTParty’s headers option to pass auth_token to the request to properly authenticate against the Bloc API.
      # Use the HTTParty’s body option to pass all of the attributes to the request (sender, recipient_id, token, subject, stripped-text)
      response = self.class.post(api_url("messages"),
      headers: { "authorization" => @auth_token },
      body:{
        "sender" => sender,
        "recipient_id" => recipient_id,
        "token" => token,
        "subject" => subject,
        "stripped-text" => stripped-text
      })

      @auth_token = response["auth_token"]

      puts "You're message was sent!" if response.success?
      # Then let’s return a message if the response is successful.
  end
end
