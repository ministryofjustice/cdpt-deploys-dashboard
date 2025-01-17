class Site < ApplicationRecord
  validates :url, :name, :prefix, presence: true

  def refresh
    json = JSON.parse(HTTParty.get(url).body)
    self.built_at = json["build_date"]
    self.commit = json["git_commit"] || json["commit_id"]
    self.tag = json["build_tag"]
    save!
    true
  rescue StandardError
    errors.add(:url)
    false
  end

  def main_url
    url.gsub("/ping", "")
  end

  def branch
    if tag.present?
      matches = tag.match("#{prefix}-(?<branch>.+)-.+")
      if matches.present?
        matches["branch"]
      else
        "Branch not found, check site details"
      end
    else
      "Branch not found"
    end
  end

  def jira
    return if branch.blank?

    if branch.downcase.starts_with?("cdpt")
      "CDPT-#{branch.delete('^0-9')}"
    end
  end

  def jira_link
    "https://dsdmoj.atlassian.net/browse/#{jira}" if jira.present?
  end
end
