sudo docker container ls
sudo docker container run hello-world
sudo systemctl start docker
sudo docker info
sudo systemctl enable docker
sudo systemctl stop docker
sudo docker image pull alpine
sudo docker image ls
sudo docker container run -id --name demo alpine ash
sudo groupadd docker
sudo useradd dockertest
sudo usermod -aG docker dockertest
man docker
man docker ps
man docker-ps
sudo docker version
sudo docker search --limit 5 alpine
sudo docker search \
--filter is-automated=true \
--filter stars=20 alpine
sudo docker search --filter is-automated=true alpine
sudo docker search --help
sudo docker image pull ubuntu
sudo docker image pull centos:centos7
sudo docker image pull --all-tags alpine
sudo docker image pull --help
sudo docker image ls
sudo docker images
sudo docker image ls --help
sudo docker container run -i -t --name mycontainer ubuntu /bin/bash

ID=$(sudo docker container create -t -i ubuntu /bin/bash)
sudo docker container start -a -i $ID

sudo docker container run -d -i -t ubuntu /bin/bash

ID=$(sudo docker container run -d -t -i ubuntu /bin/bash)
sudo docker attach $ID

sudo docker container run -d ubuntu \
/bin/bash -c \
"while [ true ]; do date; sleep 1; done"

sudo docker container ls
sudo docker run --rm ubuntu date
sudo docker container ls

sudo docker container run --read-only --rm \
ubuntu touch file

sudo docker container ls
sudo docker ps

sudo docker container ls -l
sudo docker container logs --help

sudo docker container ls
ID=$(sudo docker run -d -i ubuntu /bin/bash)
sudo docker stop $ID
sudo docker container ls

sudo docker stop $(sudo docker ps -q)
sudo docker container ls

sudo docker container stop --help

ID=$(sudo docker container create ubuntu /bin/bash)
sudo docker container stop $ID
sudo docker container rm $ID

sudo docker container stop $(sudo docker container ls -q)
sudo docker container rm $(sudo docker container ls -aq)

sudo docker container rm --help

sudo docker ps -a
sudo docker container create --name c1 ubuntu /bin/bash
sudo docker container run --name c2 ubuntu /bin/bash
sudo docker container ls -a
sudo docker container prune

sudo docker container prune --help

sudo docker container run --restart=always -d -i -t ubuntu /bin/bash
sudo docker container run --restart=on-failure:3 \
-d -i -t ubuntu /bin/bash

sudo docker container run --privileged -i -t ubuntu /bin/bash
sudo docker container run --device=/dev/sdc:/dev/xvdc \
-i -t ubuntu /bin/bash

ID=$(sudo docker container run -d redis)
sudo docker container exec -it $ID /bin/bash

ID=$(sudo docker container run -d -i ubuntu /bin/bash)
sudo docker container inspect $ID

sudo docker container inspect \
--format='{{.NetworkSettings.IPAddress}}'

sudo docker container inspect --help

sudo docker container run \
--label com.example.container=docker-cookbook \
label-demo date
sudo docker container ls -a
sudo docker container ls -a
sudo docker container inspect

sudo docker container run --help
sudo docker container diff
sudo docker container commit --help

sudo docker login
sudo docker logout
sudo docker info
sudo docker info | egrep Username

sudo docker container run -it ubuntu /bin/bash
apt-get update
apt-get install -y apache2
sudo docker container ls
sudo docker container commit --author 'nima' --message 'ubuntu with apache2' 441740e5e539 myapache2
sudo docker image ls

sudo docker image tag myapache2 yeganehnimad/myapache2
sudo docker image push yeganehnimad/myapache2

sudo docker push --help
sudo docker image history myapache2
sudo docker image inspect --format='{{.Comment}}' myapache2
sudo docker image history --help
sudo docker container stop $(sudo docker container ls -q)
sudo docker container rm $(sudo docker container ls -a -q)
sudo docker image rm $(sudo docker image ls -q)
sudo docker image rm --help
sudo docker image save --output=myapache2.tar myapache2
sudo docker container export --output=myapache2_cont.tar c71ae52e382d
sudo docker image save -help
sudo docker container export --help
sudo docker image import myapache2.tar apache2:imported
sudo docker image import --help

sudo docker image import --help
mkdir sample_image
cd sample_image
cat Dockerfile
vi Dockerfile

# Use ubuntu as the base image
FROM ubuntu
# Add author's name
LABEL maintainer="nima"
# Add the command to run at the start of container
CMD date

sudo docker image build .
sudo docker image build -t sample .

sudo docker image build --help

mkdir apache2_sample_image
cd apache2_sample_image
cat Dockerfile
vi Dockerfile

FROM alpine
LABEL maintainer="nimayeganeh"
RUN apk add --no-cache apache2 && \
mkdir -p /run/apache2 && \
echo "<html><h1>Docker Test</h1></html>" > \
/var/www/localhost/htdocs/index.html
EXPOSE 80
ENTRYPOINT ["/usr/sbin/httpd", "-D", "FOREGROUND"]

sudo docker image build -t apache2_test .

ID=$(sudo docker container run -d -p 8081:80 apache2_test)
IP=$(sudo docker container inspect --format='{{.NetworkSettings.IPAddress}}' $ID)
sudo curl $IP

sudo docker container run -d -p 5000:5000 \
--name registry registry:2
sudo docker tag apache2_test localhost:5000/apache2_test
sudo docker image push localhost:5000/apache2_test

sudo ip addr show docker0
sudo ip addr

sudo docker container run --rm -it alpine
sudo docker container run --rm --network=host alpine brctl show
sudo iptables -t nat -L -n
sudo docker run --rm alpine traceroute -m 3 -n 8.8.8.8
sudo iptables -t nat -L -n
sudo docker container run --help
sudo docker container run -it --rm alpine sh
sudo docker network ls
sudo docker container run --rm --net=none alpine ip address
sudo docker container run -itd --name=ipcontainer alpine
sudo docker container exec ipcontainer ip addr
sudo docker container run --rm --net container:ipcontainer alpine ip addr
sudo docker container run -itd --net container:ipcontainer --name service1 alpine
sudo docker container exec service1 ip addr
sudo docker network create newnet
sudo docker network inspect newnet
sudo ip addr
sudo iptables -t nat -L -n
sudo docker network create 10dot1net --subnet 10.1.0.0/16
sudo docker container run -itd --name container1 --network-alias netalias --net newnet alpine
sudo docker container run -itd --name container2 --network-alias netalias --net newnet alpine
sudo docker container run -itd --name container3 --network-alias netalias --net newnet alpine
sudo docker container inspect --format '{{ .NetworkSettings.Networks.nenet.IPAddress }}' container1
sudo docker container inspect container1
sudo docker container run --rm --net newnet alpine ping -c1 container1
sudo docker container run --rm --net newnet alpine ping -c1 netalias
sudo docker container run --rm --net newnet alpine dig netalias
sudo docker network create --help
sudo dig -h

sudo docker volume create datavol
sudo docker volume create ls
sudo docker container run -it --rm -v datavol:/data alpine
echo "This is a named volume demo" > /data/demo.txt

sudo docker container run --rm -v datavol:/data ubuntu cat /data/demo.txt
sudo docker volume inspect datavol
sudo apt install -y tree
sudo tree -a /var/lib/docker/volumes/datavol
sudo docker volume create -help
sudo docker volume ls -help
sudo docker volume inspect -help
sudo echo $HOME
sudo mkdir $HOME/data_share
sudo echo "data sharing demo" > $HOME/data_share/demo.txt
sudo docker container run --rm -v $(HOME)/data_share:/data ubuntu cat /data/demo.txt
sudo docker container run --rm -v /home/nima/data_share:/data ubuntu cat /data/demo.txt
sudo docker container run --rm -v /home/nima/data_share/demo.txt:/demo.txt ubuntu cat /demo.txt

sudo touch file
sudo docker container run --rm -v /home/nima/file:/file:rw ubuntu sh -c "echo rw mode >> /file"
sudo cat file


