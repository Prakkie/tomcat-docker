docker stop tomcat
docker run -d --rm --name tomcat -e TOMCAT_XMX=1024m -e TOMCAT_PERM=1024m -e TZ=Asia/Kolkata -p 9092:8080 tomcat:8
