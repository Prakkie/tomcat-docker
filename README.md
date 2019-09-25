# Sample Dockerfile to create tomcat 8 docker container

## How to use
1. Clone this repository
2. Edit run-command.sh to set required XMX, PERM size for tomcat as well as timezone and port mapping.
3. Run run-command.sh.
4. Check in `docker ps -a` for container named tomcat running.
5. If runnning successfully, you can access tomcat manager using http://< hostname >:9092 (assuming port mapped in run-command.sh is 9092).
