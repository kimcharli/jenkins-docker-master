# jenkins master in docker

[![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/kimcharli/jenkins-docker-master.svg)](https://cloud.docker.com/repository/docker/kimcharli/jenkins-docker-master)
[![Docker Cloud Status](https://img.shields.io/docker/cloud/build/kimcharli/jenkins-docker-master.svg)](https://cloud.docker.com/repository/docker/kimcharli/jenkins-docker-master)

docker repo: https://cloud.docker.com/repository/docker/kimcharli/jenkins-docker-master


## run jenkins master

### git clone
git clone in the master host
```
git clone https://github.com/kimcharli/jenkins-docker-master.git
cd jenkins-docker-master
```

### bring it up
```
docker-compose up -d
```

### take initial password and put in **Unlock Jenkins page**
```
docker exec jenkins-master cat /var/jenkins_home/secrets/initialAdminPassword
65b2e47c69ba4f6ea7b27e4577d595cb
```

or in 
```
docker exec -it jenkins-master bash
echo 'jenkins.model.Jenkins.instance.securityRealm.createAccount("contrail", "contrail")' |
java -jar /var/jenkins_home/war/WEB-INF/jenkins-cli.jar -auth admin:$(cat /var/jenkins_home/secrets/initialAdminPassword) -s http://localhost:8080/ groovy =
```


### click **Install Suggested Plugins** in **Customize Jenkins**

### fill out **Create First Admin User** form
TIP: example: contrail/contrail123/contrail123/contrail/ckim@juniper.net

### check **Jenkins URL** in **Instance Configuration**
click **Save and Finish**

### Jenkins is Reday
click **Start Using Jenkins**


## to shut it down
```
docker-compose down -v
```









## customization

### replace ssh key
```
mkdir -p data/_ssh
ssh-keygen -b 2048 -t rsa -f data/_ssh/id_rsa -q -C "jenkins" -N ""
```

### update specific version of docker client binary for master
```
curl -s https://download.docker.com/linux/static/stable/x86_64/docker-18.09.5.tgz | tar zxf - -C jenkins docker/docker
```

### install specific version of docker compose
```
sudo curl -L https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

### fix docker network range
edit /etc/docker/daemon.json and restart docker
```json
{
  "debug" : true,
  "default-address-pools" : [
    {
      "base" : "172.17.0.0/16",
      "size" : 24
    }
  ]
}
```



## TODO
- implement python3 once pyez endorses
- docker agent tcp setup
- pre-loaded (by docker-compose) password and project

