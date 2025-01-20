Site.find_or_create_by!(
  name: "Track a Query",
  environment: "Production",
  prefix: "ct-staff",
  url: "https://track-a-query.service.justice.gov.uk/ping",
)

Site.find_or_create_by!(
  name: "People Finder",
  environment: "Production",
  prefix: "pf",
  url: "https://peoplefinder.service.gov.uk/ping",
)
