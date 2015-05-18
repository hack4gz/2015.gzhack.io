ISSUE_PATH = "https://api.github.com/orgs/gzhack/issues"
OAUTH_TOKEN = "29083a5f025ad655b8083c32781b00d46332f0dc"

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
  $headerElem = $('header')
  $bannerElem = $('.introduction-banner')
  windowHeight = window.innerHeight
  headerHeight = $headerElem[0].offsetHeight

  $bannerElem.height(windowHeight - headerHeight)

  jssor_slider = new $JssorSlider$ 'js_slider', {
    $PauseOnHover: 0
    $Duration: 1000
    $FillMode: 2
    $BulletNavigatorOptions:
      $Class: $JssorBulletNavigator$
      $ChanceToShow: 2
  }

  # Compatible size

  $window = $(window)
  $body = $("body")
  if $window.width() > 1440
    $body.addClass("screen_max") unless $body.hasClass("screen_max")

  $window.on('resize', () ->
    if $window.width() < 1440 and $body.hasClass("screen_max")
      $body.removeClass("screen_max")
    if $window.width() > 1440 and !$body.hasClass("screen_max")
      $body.addClass("screen_max")
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
