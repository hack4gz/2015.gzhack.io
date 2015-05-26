module WelcomeHelper
  # 用于生成照片墙所需 HTML 代码
  #
  # name: 成员姓名
  # introduction: 成员的自我介绍内容
  # class_name: 成员对应 css 的 class name
  #
  # 示例:
  #
  # => team_member("嘉豪", "总打杂，没人写代码的时候写代码，没人写文案的时候写文案，没人拉口条的时候拉口条", "jiahao")
  #
  # <li class="item">
  #   <div class="introduction-container">
  #     <div class="content">
  #       总打杂，没人写代码的时候写代码，没人写文案的时候写文案，没人拉口条的时候拉口条
  #     </div>
  #     <div class="triangle"></div>
  #   </div>
  #   <div class="background-renderer jiawen"></div>
  #   <div class="name">嘉豪</div>
  # </li>
  #
  def team_member(name, introduction, class_name = nil)
    content_tag :li, class: 'item' do
      introduction = content_tag :div, class: "introduction-container" do
        content = content_tag :div, introduction, class: 'content'
        triangle = content_tag :div, nil, class: 'triangle'

        content + triangle
      end

      avatar = content_tag :div, nil, class: "background-renderer #{class_name}"
      name = content_tag :div, name, class: "name"

      introduction + avatar + name
    end
  end

  # 用于生成合作方 logo 的 section 内容代码
  #
  # member_list: 合作伙伴列表
  #   link (optional)   合作伙伴友链
  #   name              合作伙伴名称
  #   anchor (optional) 合作伙伴的anchor(当友链不存在时使用)
  #
  # 示例:
  #
  # => dataSources = [
  #      { link: "http://air.epmap.org/", name: "上海青悦" },
  #      { anchor: "qingyue", name: "有米传媒" }
  #    ]
  # => partner_members(dataSources)
  #
  # <ul>
  #   <li class="partner partner-0">
  #     <a href="http://air.epmap.org/?from=gzhack"></a>
  #   </li>
  #   <li class="partner partner-1">
  #     <a href="#qingyue"></a>
  #   </li>
  # </ul>
  #
  def partner_members(member_list)
    li_list = member_list.map.with_index do |member, index|
      content_tag :li, class: "partner partner-#{index}" do
        if member[:link]
          link_to "", "#{member[:link]}?from=gzhack", target: "_blank"
        else
          link_to "", "##{member[:anchor]}", target: "_blank"
        end
      end
    end
    content_tag :ul do
      raw li_list.join("")
    end
  end
end
