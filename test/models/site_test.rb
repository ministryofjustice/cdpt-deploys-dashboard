require "test_helper"
require "webmock/minitest"

class SiteTest < ActiveSupport::TestCase
  setup do
    @site = sites(:one)
  end

  test "valid with name, url and prefix" do
    assert @site.valid?
  end

  test "invalid without name, url or prefix" do
    site = Site.new
    assert_not site.valid?
    assert_includes site.errors.attribute_names, :name
    assert_includes site.errors.attribute_names, :url
    assert_includes site.errors.attribute_names, :prefix
  end

  test "refresh updates build attributes from response" do
    stub_request(:get, @site.url).to_return(
      body: { "build_date" => "2024-01-02T03:04:05Z", "git_commit" => "abc123", "build_tag" => "example-main-abc123" }.to_json,
    )

    assert @site.refresh
    assert_equal "abc123", @site.commit
    assert_equal "example-main-abc123", @site.tag
    assert_equal Time.zone.parse("2024-01-02T03:04:05Z"), @site.built_at
  end

  test "refresh falls back to commit_id when git_commit missing" do
    stub_request(:get, @site.url).to_return(
      body: { "commit_id" => "def456" }.to_json,
    )

    assert @site.refresh
    assert_equal "def456", @site.commit
  end

  test "refresh returns false and adds error on failure" do
    stub_request(:get, @site.url).to_raise(SocketError)

    assert_not @site.refresh
    assert_includes @site.errors.attribute_names, :url
  end

  test "main_url strips ping suffix" do
    @site.url = "https://example.com/ping"
    assert_equal "https://example.com", @site.main_url
  end

  test "branch extracts branch from tag" do
    @site.prefix = "example"
    @site.tag = "example-main-abc123"
    assert_equal "main", @site.branch
  end

  test "branch reports not found when tag missing" do
    @site.tag = nil
    assert_equal "Branch not found", @site.branch
  end

  test "branch reports check details when tag does not match" do
    @site.prefix = "example"
    @site.tag = "no-match"
    assert_equal "Branch not found, check site details", @site.branch
  end

  test "jira builds ticket for cdptkan branches" do
    @site.prefix = "example"
    @site.tag = "example-cdptkan1234-abc123"
    assert_equal "CDPTKAN-1234", @site.jira
  end

  test "jira is nil for non cdptkan branches" do
    @site.prefix = "example"
    @site.tag = "example-main-abc123"
    assert_nil @site.jira
  end

  test "jira_link builds url when jira present" do
    @site.prefix = "example"
    @site.tag = "example-cdptkan1234-abc123"
    assert_equal "https://dsdmoj.atlassian.net/browse/CDPTKAN-1234", @site.jira_link
  end

  test "jira_link is nil when jira absent" do
    @site.prefix = "example"
    @site.tag = "example-main-abc123"
    assert_nil @site.jira_link
  end
end
