ISSUE_PATH = "https://api.github.com/orgs/gzhack/issues"
OAUTH_TOKEN = "f47d4d1f44f7b3386f7fb36499b9fa41b7ed4c21"

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
    return
).fail((xhr, textStatus, err) ->
  console.log "Failed"
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

$(document).ready () ->

  $window = $(window)
  # FAQ tabs

  $('#faq .tab').click (e) ->
    $this = $(e.target)
    contentClass = $this.data("content")
    unless $this.hasClass("active")
      $('#faq .tab.active').removeClass "active"
      $('#faq .content.active').removeClass "active"
      $this.addClass "active"
      $("#faq .content.#{contentClass}").addClass "active"
    return

  # Slider

  if window.chrome
    $('#js-slider li').css('background-size', '100% 100%')

  adjustSlider = (windowWidth) ->
    height = windowWidth * 920 / 1980
    $('#js-slider ul li').height(height);
    $('#js-slider ul li').css('min-height', height);

    if windowWidth < 600
      fontSize = '12px'
    else if windowWidth < 960
      fontSize = '15px'
    else if windowWidth < 1440
      fontSize = '18px'
    else
      fontSize = 18 * 1.2 + 'px'

    $('.signup_button div').css('font-size', fontSize);

    $('#js-slider').height(height);

  adjustSlider()
  $('#js-slider').unslider(
    delay: 3000
    speed: 500
    fluid: true
    dots: true
    pause: true
  )

  # Compatible size

  $window = $(window)
  $body = $("body")
  if $window.width() > 1440
    $body.addClass("screen_max") unless $body.hasClass("screen_max")

  $window.on('resize', () ->
    width = $window.width()
    if width < 1440 and $body.hasClass("screen_max")
      $body.removeClass("screen_max")
    if width > 1440 and !$body.hasClass("screen_max")
      $body.addClass("screen_max")

    adjustSlider(width)
    return
  )

  # Baidu map

  ICON_URI = "http://api.map.baidu.com/lbsapi/createmap/images/icon.png"

  # 创建和初始化地图函数
  initMap = () ->
    map = createMap() #创建地图
    setMapEvent(map) #设置地图事件
    addMapControl(map) #向地图添加控件
    addMapOverlay(map) #向地图添加覆盖物
    return

  createMap = () ->
    map = new BMap.Map("map");
    map.centerAndZoom(new BMap.Point(113.38044,23.073011),16);
    return map
  setMapEvent = (map) ->
    map.enableScrollWheelZoom()
    map.enableKeyboard()
    map.enableDragging()
    map.enableDoubleClickZoom()
    return

  addClickHandler = (target,window) ->
    target.addEventListener "click", () ->
      target.openInfoWindow window
    return

  # 添加覆盖物
  addMapOverlay = (map) ->
    markers = [
      content:"我的备注"
      title:"6CIT Cafe"
      imageOffset:
        width:-46
        height:-21
      position:
        lat:23.062794
        lng:113.39217
    ]
    for m, index in markers
      point = new BMap.Point(m.position.lng, m.position.lat)
      marker = new BMap.Marker(point,
        icon: new BMap.Icon(ICON_URI, new BMap.Size(20,25),
          imageOffset: new BMap.Size(m.imageOffset.width,m.imageOffset.height)
        )
      )
      label = new BMap.Label(m.title,
        offset: new BMap.Size(25, 5)
      )
      opts =
        width: 200
        title: m.title
        enableMessage: false
      infoWindow = new BMap.InfoWindow(m.content, opts)
      marker.setLabel label
      addClickHandler marker, infoWindow
      map.addOverlay marker
    return

  # 向地图添加控件
  addMapControl = (map) ->
    scaleControl = new BMap.ScaleControl(
      anchor: BMAP_ANCHOR_BOTTOM_LEFT
    )
    scaleControl.setUnit BMAP_UNIT_IMPERIAL
    map.addControl scaleControl
    navControl = new BMap.NavigationControl(
      anchor:BMAP_ANCHOR_TOP_LEFT
      type:BMAP_NAVIGATION_CONTROL_LARGE
    )
    map.addControl navControl
    overviewControl = new BMap.OverviewMapControl(
      anchor:BMAP_ANCHOR_BOTTOM_RIGHT
      isOpen:true
    )
    map.addControl overviewControl
    return

  initMap()
  return
