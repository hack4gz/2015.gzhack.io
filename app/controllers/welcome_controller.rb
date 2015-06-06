class WelcomeController < ApplicationController
  def index
    @partners = [
      # organizers:
      { name: "六矽科技众创空间", link: "http://6cit.com/" },
      { name: "Hack For GZ" },
      { name: "东西科技" },
      { name: '星海数字家庭产业技术研究院有限公司' },

      # sponsors:
      { name: "国家超级计算广州中心", link: "http://www.nscc-gz.cn/"  },
      { name: "BearyChat", link: "https://bearychat.com/" },

      # medias:
      { name: "魔格工作室" },
      { name: "活动行", link: "http://www.huodongxing.com/" },
      { name: "公益服务网 | NGO 发展交流网", link: "http://www.ngocn.net/" },
      { name: "TechNode", link: "http://technode.com/" },
      { name: "SegmentFault", link: "http://segmentfault.com/" },
      { name: "创客时代" },

      # dataSources:
      { name: "上海青悦", link: "http://air.epmap.org/" },
      { name: "未来交通实验室" },
      { name: "AKIRALAND" },

      # communities
      { name: "首尔国际创客马拉松", link: "https://seoul.globalhackathon.io/" },
      { name: "Beansmile", link: "http://beansmile.com/", },
      { name: "Code For HK", link: "http://www.code4.hk/" },
      { name: "开放数据中国", link: "http://opendatachina.com/",  },
      { name: "珠三角技术沙龙", link: "http://techparty.org/" },
      { name: "城市数据派", link: "http://www.udparty.com/",  },
      { name: "StartupGrind 广州", link: "http://startupgrind.com/guangzhou/" },
      { name: "火狐科技" },
      { name: "创元素", link: "http://i-element.org/",  },
      { name: "梦车间", link: "http://www.mongcj.com" },
      { name: "中山大学学生软件技术发展中心", link: "http://ss.sysu.edu.cn/",  },
      { name: "华工百步梯", link: "http://100steps.net/" },
      { name: "暨南大学政务数据开放与社会创新创业研究中心" },
      { name: "坊间" }

    ]
  end
end
