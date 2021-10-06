#! /bin/bash
wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list
sudo apt-get update -y
sudo apt-get install -y mongodb-org
sudo su
sudo systemctl start mongod
sudo systemctl start mongod
private_ip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
sudo cat <<EOF >> /etc/mongod.conf
replication:
    replSetName: "rs1"
EOF
sudo sed -i 's/127.0.0.1/'"127.0.0.1,$private_ip"'/' /etc/mongod.conf
sudo systemctl restart mongod
