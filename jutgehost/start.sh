IP=`ip -4 addr show enp0s3 | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | tr -d \.`
export JUDGEHOST_NAME="judgehost-$IP"
docker-compose up
