require "rails_helper"

RSpec.describe Site do
  let(:site) { sites(:one) }

  it "is valid with name, url and prefix" do
    expect(site).to be_valid
  end

  it "is invalid without name, url or prefix" do
    site = described_class.new
    expect(site).not_to be_valid
    expect(site.errors.attribute_names).to include(:name, :url, :prefix)
  end

  describe "#refresh" do
    it "updates build attributes from response" do
      stub_request(:get, site.url).to_return(
        body: { "build_date" => "2024-01-02T03:04:05Z", "git_commit" => "abc123", "build_tag" => "example-main-abc123" }.to_json,
      )

      expect(site.refresh).to be true
      expect(site.commit).to eq("abc123")
      expect(site.tag).to eq("example-main-abc123")
      expect(site.built_at).to eq(Time.zone.parse("2024-01-02T03:04:05Z"))
    end

    it "falls back to commit_id when git_commit missing" do
      stub_request(:get, site.url).to_return(
        body: { "commit_id" => "def456" }.to_json,
      )

      expect(site.refresh).to be true
      expect(site.commit).to eq("def456")
    end

    it "returns false and adds error on failure" do
      stub_request(:get, site.url).to_raise(SocketError)

      expect(site.refresh).to be false
      expect(site.errors.attribute_names).to include(:url)
    end
  end

  describe "#main_url" do
    it "strips ping suffix" do
      site.url = "https://example.com/ping"
      expect(site.main_url).to eq("https://example.com")
    end
  end

  describe "#branch" do
    it "extracts branch from tag" do
      site.prefix = "example"
      site.tag = "example-main-abc123"
      expect(site.branch).to eq("main")
    end

    it "reports not found when tag missing" do
      site.tag = nil
      expect(site.branch).to eq("Branch not found")
    end

    it "reports check details when tag does not match" do
      site.prefix = "example"
      site.tag = "no-match"
      expect(site.branch).to eq("Branch not found, check site details")
    end
  end

  describe "#jira" do
    it "builds ticket for cdptkan branches" do
      site.prefix = "example"
      site.tag = "example-cdptkan1234-abc123"
      expect(site.jira).to eq("CDPTKAN-1234")
    end

    it "is nil for non cdptkan branches" do
      site.prefix = "example"
      site.tag = "example-main-abc123"
      expect(site.jira).to be_nil
    end
  end

  describe "#jira_link" do
    it "builds url when jira present" do
      site.prefix = "example"
      site.tag = "example-cdptkan1234-abc123"
      expect(site.jira_link).to eq("https://dsdmoj.atlassian.net/browse/CDPTKAN-1234")
    end

    it "is nil when jira absent" do
      site.prefix = "example"
      site.tag = "example-main-abc123"
      expect(site.jira_link).to be_nil
    end
  end
end
