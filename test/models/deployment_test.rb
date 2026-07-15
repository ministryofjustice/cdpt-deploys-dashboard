require "test_helper"

class DeploymentTest < ActiveSupport::TestCase
  test "info returns build details from env" do
    env = {
      "APP_BUILD_DATE" => "2024-01-02",
      "APP_GIT_COMMIT" => "abc123",
      "APP_BUILD_TAG" => "v1.0.0",
    }

    assert_equal(
      { build_date: "2024-01-02", commit_id: "abc123", build_tag: "v1.0.0" },
      Deployment.new(env).info
    )
  end
end
