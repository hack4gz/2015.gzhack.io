module WelcomeHelper
  # 用于生成照片墙所需 HTML 代码
  #
  # name: 成员姓名
  # introduction: 成员的自我介绍内容
  # class_name: 成员对应 css 的 class name，样式表根据此名称渲染正确的头像
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
  def team_member(name, introduction, class_name)
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
end
