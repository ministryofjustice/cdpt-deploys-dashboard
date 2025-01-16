# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Site.find_or_create_by!(
  name: "Track a Query Development",
  prefix: "ct-staff",
  url: "https://#{ENV['BASIC_AUTH']}@development.track-a-query.service.justice.gov.uk/ping",
)

Site.find_or_create_by!(
  name: "Track a Query Production",
  prefix: "ct-staff",
  url: "https://track-a-query.service.justice.gov.uk/ping",
)

Site.find_or_create_by!(
  name: "People Finder Development",
  prefix: "pf",
  url: "https://#{ENV['BASIC_AUTH']}@development.peoplefinder.service.gov.uk/ping",
)

Site.find_or_create_by!(
  name: "People Finder Production",
  prefix: "pf",
  url: "https://peoplefinder.service.gov.uk/ping",
)
