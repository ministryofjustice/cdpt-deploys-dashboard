Site.find_or_create_by!(
  name: "Track a Query Production",
  prefix: "ct-staff",
  url: "https://track-a-query.service.justice.gov.uk/ping",
)

Site.find_or_create_by!(
  name: "People Finder Production",
  prefix: "pf",
  url: "https://peoplefinder.service.gov.uk/ping",
)
