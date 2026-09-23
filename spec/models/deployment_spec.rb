require "rails_helper"

RSpec.describe Deployment do
  describe "#info" do
    it "returns build details from env" do
      env = {
        "APP_BUILD_DATE" => "2024-01-02",
        "APP_GIT_COMMIT" => "abc123",
        "APP_BUILD_TAG" => "v1.0.0",
      }

      expect(described_class.new(env).info).to eq(
        build_date: "2024-01-02",
        commit_id: "abc123",
        build_tag: "v1.0.0",
      )
    end
  end
end
