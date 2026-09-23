require "rails_helper"

RSpec.describe "Sites" do
  let(:site) { sites(:one) }
  let(:params) { site.slice(:name, :environment, :url, :prefix) }

  before do
    stub_request(:get, site.url).to_return(
      body: { build_date: site.built_at, git_commit: site.commit, build_tag: site.tag }.to_json,
    )
  end

  describe "GET /sites" do
    it "responds successfully" do
      get sites_url
      expect(response).to be_successful
    end
  end

  describe "GET /sites/new" do
    it "responds successfully" do
      get new_site_url
      expect(response).to be_successful
    end
  end

  describe "POST /sites" do
    it "creates a site" do
      expect { post sites_url, params: { site: params } }.to change(Site, :count).by(1)
      expect(response).to redirect_to(root_path)
    end
  end

  describe "GET /sites/:id/edit" do
    it "responds successfully" do
      get edit_site_url(site)
      expect(response).to be_successful
    end
  end

  describe "PATCH /sites/:id" do
    it "updates the site" do
      patch site_url(site), params: { site: params }
      expect(response).to redirect_to(root_path)
    end
  end

  describe "DELETE /sites/:id" do
    it "destroys the site" do
      expect { delete site_url(site) }.to change(Site, :count).by(-1)
      expect(response).to redirect_to(root_path)
    end
  end
end
