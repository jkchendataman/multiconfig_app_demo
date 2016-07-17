# 配置管理demo

1. 构建配置管理容器。将所有配置文件拷贝或者挂载到此容器中的nginx发布目录，通过nginx服务下载或读取配置文件。

		#-------------------------------------
		#构建/发布配置管理镜像
		#-------------------------------------
		cd config 
		docker build -t config .
		docker run --net=host -d config (why must host?FIXME)

2. 构建sample应用容器。index.jsp通过容器env获得配置文件链接并读取配置文件。

		#-------------------------------------
		# For Weblogic12.2.1
		#-------------------------------------
		cd sample 
		# 构建/发布weblogic12.2.1 sample应用镜像
		docker build -t sample:weblogic -f Dockerfile.weblogic .
		#开发环境发布应用
		docker run -p 8001:8001 -e CONFIG=http://IPADDR/dev.properties -d sample:weblogic
		＃测试环境发布应用
		docker run -p 8001:8001 -e CONFIG=http://IPADDR/test.properties -d sample:weblogic
		＃生产环境发布应用
		docker run -p 8001:8001 -e CONFIG=http://IPADDR/oneline.properties -d sample:weblogic
		＃准生产环境发布应用
		docker run -p 8001:8001 -e CONFIG=http://IPADDR/pre-online.properties -d sample:weblogic
		
		#-------------------------------------
		# For tomcat 8.0
		#-------------------------------------
		cd sample
		#构建tomcat8.0 sample应用镜像
		docker build -t sample:tomcat -f Dockerfile.tomcat .
		#开发环境发布应用
		docker run -p 8080:8080 -e CONFIG=http://IPADDR/dev.properties -d sample:tomcat
		＃测试环境发布应用
		docker run -p 8080:8080 -e CONFIG=http://IPADDR/test.properties -d sample:tomcat
		＃生产环境发布应用
		docker run -p 8080:8080 -e CONFIG=http://IPADDR/oneline.properties -d sample:tomcat
		＃准生产环境发布应用
		docker run -p 8080:8080 -e CONFIG=http://IPADDR/pre-online.properties -d sample:tomcat
		
		
		
		
