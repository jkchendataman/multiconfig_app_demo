# 配置管理demo

1. 构建配置管理容器。将所有配置文件拷贝或者挂载到此容器中的nginx发布目录，通过nginx服务，提供配置文件下载浏览功能。

		cd config 

		#构建配置管理镜像
		docker build -t config .
	
		#发布配置管理容器
		docker run --net=host -d config

2. 构建sample应用容器。sample应用是一个weblogic应用。应用的index.jsp通过容器env获得配置文件浏览链接，下载配置文件。

		cd sample 

		#构建sample应用镜像
			#构建weblogic12.2.1 sample应用镜像
			docker build -t sample -f Dockerfile.weblogic .
			#构建tomcat8.0 sample应用镜像
			docker build -t sample -f Dockerfile.tomcat .
	
		#发布sample应用容器
			#开发环境发布应用
			docker run -p 8001:8001 -e CONFIG=http://IPADDR/dev.properties -d sample
			＃测试环境发布应用
			docker run -p 8001:8001 -e CONFIG=http://IPADDR/test.properties -d sample
			＃生产环境发布应用
			docker run -p 8001:8001 -e CONFIG=http://IPADDR/oneline.properties -d sample
			＃准生产环境发布应用
			docker run -p 8001:8001 -e CONFIG=http://IPADDR/pre-online.properties -d sample