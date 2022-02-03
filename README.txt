1. Change username and password in ./setup.sh:

MONGO_INITDB_ROOT_USERNAME=<username>
MONGO_INITDB_ROOT_PASSWORD=<pass>

2. Change docker network subnet if needed in ./setup.sh (do not change network name, or set same in all docker-compose.yml files):
docker network create --driver=bridge --subnet=10.10.0.0/16 --ip-range=10.10.1.1/24 --gateway=10.10.0.1 rocketnet

3. Change ROOT_URL in 3 instance of Rocketchat in ./rocketchat/docker-compose.yml:
- ROOT_URL=http://<your FQDN>

4. Change "server_name" in ./web/nginx/rocket.conf: 

server_name  example.ru www.example.com;

5. Run ./setup.sh:
sudo ./setup.sh 
