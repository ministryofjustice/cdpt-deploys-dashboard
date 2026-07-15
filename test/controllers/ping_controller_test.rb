require "test_helper"

class PingControllerTest < ActionDispatch::IntegrationTest
  test "responds successfully" do
    get ping_url
    assert_response :success
  end

  test "responds with json" do
    get ping_url
    assert_equal "application/json", response.media_type
  end

  test "renders deployment info" do
    get ping_url

    assert_equal Deployment.info.stringify_keys, JSON.parse(response.body)
  end
end
