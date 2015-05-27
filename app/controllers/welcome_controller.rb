class WelcomeController < ApplicationController
  def index
    @organizers = [
      { link: "http://6cit.com/", name: "六矽科技众创空间" },
      { name: "Hack For GZ", anchor: "partners" },
      { name: "东西科技", anchor: "partners" }
    ]
    @medias = [
      { link: "http://segmentfault.com/", name: "SegmentFault" },
      { link: "http://www.huodongxing.com/", name: "活动行" },
      { link: "http://www.ngocn.net/", name: "公益服务网 | NGO 发展交流网" },
      { anchor: "moge", name: "魔格工作室" }
    ]
    @dataSources = [
      { link: "http://air.epmap.org/", name: "上海青悦" },
      { link: "https://www.youmi.net/", name: "有米传媒" }
    ]
    @communities = [
      { link: "https://seoul.globalhackathon.io/", name: "首尔国际创客马拉松" },
      { link: "http://beansmile.com/", name: "Beansmile" },
      { link: "http://www.code4.hk/", name: "Code For HK" },
      { link: "http://opendatachina.com/", name: "开放数据中国" },
      { link: "http://techparty.org/", name: "珠三角技术沙龙" },
      { link: "http://www.udparty.com/", name: "城市数据派" },
      { link: "http://startupgrind.com/guangzhou/", name: "StartupGrind 广州" },
      { anchor: "huohu", name: "火狐科技" },
      { link: "http://i-element.org/", name: "创元素" },
      { link: "http://www.mongcj.com", name: "梦车间" },
      { link: "http://ss.sysu.edu.cn/", name: "中山大学学生软件技术发展中心" },
      { link: "http://100steps.net/", name: "华工百步梯" },
      { anchor: "jnu", name: "暨南大学政务数据开放与社会创新创业研究中心" }
    ]
  end
end
