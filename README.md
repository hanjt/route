##使用方式
- 核心文件在Core文件夹中
- url的host必须有，否则不能正常使用
- ROUBaseViewController中只有一个参数params，是通过url中的query传递给相应类使用，所有vc均需继承ROUBaseViewController
- route.plist中维护一个路由列表，key为url的path，vaule为对应的vc类名


