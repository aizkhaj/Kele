module Roadmap
  def get_roadmap
    roadmap_id = get_me["current_enrollment"]["roadmap_id"]
    raise 'Roadmap ID is nonexistent' if roadmap_id.nil?
    response = self.class.get("/roadmaps/#{roadmap_id}", headers: {authorization: @auth_token})
    JSON.parse(response.body)
  end

  def get_checkpoint(checkpoint_id, section_id)
    section = get_roadmap["sections"][section_id]
    check_id = section["checkpoints"][checkpoint_id]["id"]
    response = self.class.get("/checkpoints/#{check_id}", headers: {authorization: @auth_token})
    JSON.parse(response.body)
  end
end
