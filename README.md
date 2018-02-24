##使用方式
- 核心文件在Core文件夹中
- Core/Config中放置配置文件
 - route.plist中key为url的path，value为viewController
 - Configuration.h中为scheme及host，这两个不能为空，且每个项目唯一scheme，scheme与info.plist中配置的scheme相同
- Core/Base放置跟路由相关文件
 - ROUNavigator封装了导航相关文件
 - ROUEntery为viewController入口文件
 - ROUBaseViewController为所有类的父类，需要做路由跳转的类都需继承该类


