require "rails_helper"

RSpec.describe "Ping" do
  describe "GET /ping" do
    it "responds successfully" do
      get ping_url
      expect(response).to be_successful
    end

    it "responds with json" do
      get ping_url
      expect(response.media_type).to eq("application/json")
    end

    it "renders deployment info" do
      get ping_url

      expect(JSON.parse(response.body)).to eq(Deployment.info.stringify_keys)
    end
  end
end
