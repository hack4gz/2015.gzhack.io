ISSUE_PATH = "https://api.github.com/orgs/gzhack/issues"
OAUTH_TOKEN = "134efa34c41f3cb20169ac1f15c9955cd30689f9"

contributorPath = (repo)->
  "https://api.github.com/repos/gzhack/" + repo + "/stats/contributors"

$.ajax(
  url: ISSUE_PATH
  headers:
    'Authorization': "token " + OAUTH_TOKEN
  dataType: 'json'
  data:
    filter: 'all',
    labels: 'help wanted'
).done((data,textStatus, xhr) ->
  if console and console.log
    issues = data.map((d) ->
      repoName: d.repository.name
      repourl: d.repository.html_url
      repoDesc: d.repository.description
      title: d.title
      url: d.html_url
      labels: d.labels
    )
    issues = Array.prototype.slice.call(issues, 0, 4)
    # TODO build up a list of project-item DOM

).fail((xhr, textStatus, err) ->
  console.log xhr
  console.log textStatus
  console.log err
)
