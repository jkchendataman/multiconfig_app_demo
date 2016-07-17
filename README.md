# 配置管理demo

1. 构建配置管理容器。将所有配置文件拷贝或者挂载到此容器中的nginx发布目录，通过nginx服务，提供配置文件下载浏览功能。

	cd config 

	docker build -t config . 

	docker run -p 8000:80 -d config

2. 构建sample应用容器。sample应用是一个weblogic应用。应用的index.jsp通过容器env获得配置文件浏览链接，下载配置文件。

	cd sample 

	docker build -t sample . 

	docker run -p 8001:8001 -e ENV-FILE=http://IPADDR:8000/dev.properties -d sample
