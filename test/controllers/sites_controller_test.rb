require "test_helper"
require "webmock/minitest"

class SitesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @site = sites(:one)
    @params = @site.slice(:name, :environment, :url, :prefix)
    stub_request(:get, @site.url).to_return(
      body: { build_date: @site.built_at, git_commit: @site.commit, build_tag: @site.tag }.to_json,
    )
  end

  test "should get index" do
    get sites_url
    assert_response :success
  end

  test "should get new" do
    get new_site_url
    assert_response :success
  end

  test "should create site" do
    assert_difference("Site.count") do
      post sites_url, params: { site: @params }
    end
    assert_redirected_to root_path
  end

  test "should get edit" do
    get edit_site_url(@site)
    assert_response :success
  end

  test "should update site" do
    patch site_url(@site), params: { site: @params }
    assert_redirected_to root_path
  end

  test "should destroy site" do
    assert_difference("Site.count", -1) do
      delete site_url(@site)
    end
    assert_redirected_to root_path
  end
end
