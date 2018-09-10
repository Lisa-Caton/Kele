module Messages
  # Retrieves the current user's message threads.
  # Params: page_number = number(optional) If no page is specified via the parameter, the first page of messages will be displayed.
  def get_messages(page_number = 1)
    # Point the HTTParty GET method at the message_threads endpoint of Bloc's API.
    # Use HTTParty's header option to pass the auth_token.
    # Use HTTParty's body option to pass the page_number
    response = self.class.get(api_url("message_threads"),
    headers: { "authorization" => @auth_token },
    body: {
     "page": page_number
     })
   puts "This is page #{page_number} of your messages" if response.success?
   # Parse the JSON document returned in the response into a Ruby hash.
   JSON.parse(response.body)
  end

  def create_message(sender, recipient_id, token, subject, text)
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
        "stripped-text" => text
      })

      @auth_token = response["auth_token"]

      puts "You're message was sent!" if response.success?
      puts "You're having trouble" if response.nil?
      # Then let’s return a message if the response is successful.
  end
end
