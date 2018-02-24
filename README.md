##使用方式
- 核心文件在Core文件夹中
- Core/Utils中放置工具类

- Core/Config中放置配置文件
 - route.plist结构说明如下<br>
 	 ```{    
 	 
 	 	"data": {  
 	 		"/list": {  
 	 			"vc": "ListViewController",  //url对应的类名  
 	 			"present": NO		//跳转方式  
 	 		},   
 	 		"/detail": {  
 	 			"vc": "DetailViewController",  
 	 			"present": NO  
 	 		},  
 	 		"/present": {  
 	 			"vc": "PresentViewController",  
 	 			"present": YES  
 	 		},  
 	 		"/push": {  
 	 			"vc": "PushViewController",  
 	 			"present": NO  
 	 		}  
 	 	},  
 	 	sign:"0"	 //md5用于校验服务端是否有新的plist文件  
 	
 - Configuration.h中为scheme及host，这两个不能为空，且每个项目唯一scheme，scheme与info.plist中配置的scheme相同
- Core/Base放置跟路由相关文件
 - ROUNavigator封装了导航相关文件
 - ROUEntery为viewController入口文件
 
- 页面调转如下所示```[ROUEntery enteryURL:[NSString stringWithFormat:@"%@://%@/present", projectScheme, projectHost]];```

