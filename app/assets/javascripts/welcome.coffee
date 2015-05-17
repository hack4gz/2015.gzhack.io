ISSUE_PATH = "https://api.github.com/orgs/gzhack/issues"
OAUTH_TOKEN = "134efa34c41f3cb20169ac1f15c9955cd30689f9"

contributorPath = (repo)->
  "https://api.github.com/repos/gzhack/" + repo + "/stats/contributors"

count = 0

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
    count = issues.length
    issues.forEach((issue) ->
      $issue = (()->
        labelStr = issue.labels.map((l)->
                    '<div class="label">' + l.name + '</div>'
                   ).join("")
        htmlStr = "<div class='project-item'>" +
                  "<a class='wrapper' href='#{issue.url}'>" +
                  "<p class='name'>#{issue.repoName}</p>" +
                  "<h3 class='issue-title'>#{issue.title}</h3>" +
                  "<div class='labels'>#{labelStr}</div>" +
                  "</a></div>"
        $(htmlStr)
      )()
      $issue.appendTo $('.open-source-project-progress')
      return
    )
    #console.log "done"
    return
).fail((xhr, textStatus, err) ->
  console.log "Failed"
  #console.log xhr
  #console.log textStatus
  #console.log err
  return
).always((data, textStatus, xhr) ->
  backups = [
    {
      category: "项目想法"
      url: "http://wifimap.herokuapp.com"
      name: "Wifi 领养计划"
    },
    {
      category: "合作帮助"
      url: "mailto:pr@gzhack.io"
      name: "联系我们"
    },
    {
      category: "数据门户"
      url: "http://data.gzhack.io"
      name: "开放数据广州"
    },
    {
      category: "开源组织"
      url: "http://github.com/gzhack"
      name: "GZHACK repos"
    }
  ]
  if count < 4
    toAdd = Array.prototype.slice.call(backups, 0, 4 - count)
    toAdd.forEach((i) ->
      htmlStr = "<div class='project-item'>" +
                "<h6>#{i.category}</h6>" +
                "<h3><a href='#{i.url}'>#{i.name}</a></h3>" +
                "</div>"
      $(htmlStr).appendTo $('.open-source-project-progress')
    )
  return
)

# FAQ tabs

$(document).ready () ->
  $('#faq .tab').click (e) ->
    $this = $(e.target)
    contentClass = $this.data("content")
    unless $this.hasClass("active")
      $('#faq .tab.active').removeClass "active"
      $('#faq .content.active').removeClass "active"
      $this.addClass "active"
      $("#faq .content.#{contentClass}").addClass "active"
    return
