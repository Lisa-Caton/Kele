
module Roadmap
  def get_roadmap(chain_id)
<<<<<<< HEAD
    response = self.class.get(api_url('/roadmaps/#{chain_id}'), headers: { “authorization” => @auth_token })
=======
    response = self.class.get(api_url('/roadmaps/#{chain_id}'),
    headers: { “authorization” => @auth_token })
>>>>>>> 2-Rails-retrieve-users

    JSON.parse(response.body)
  end

  def get_checkpoint(checkpoint_id)
<<<<<<< HEAD
    response = self.class.get(api_url('/checkpoints/#{checkpoint_id}'), headers: { “authorization” => @auth_token })
=======
    response = self.class.get(api_url('/checkpoints/#{checkpoint_id}'),
    headers: { “authorization” => @auth_token })
>>>>>>> 2-Rails-retrieve-users

    JSON.parse(response.body)
  end

  def get_remaining_checkpoints(chain_id)
<<<<<<< HEAD
    response = self.class.get(api_url('/checkpoints/#{chain_id}'), headers: { “authorization” => @auth_token })
=======
    response = self.class.get(api_url('/checkpoints/#{chain_id}'),
    headers: { “authorization” => @auth_token })
>>>>>>> 2-Rails-retrieve-users

    JSON.parse(response.body)
  end

end
