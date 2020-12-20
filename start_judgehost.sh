# IP=`ip -4 addr show enp0s3 | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | tr -d \.`
if [ $# -lt 1 ] ; then
    echo "Si us plau, introdueix l'aula"
    echo "$0 <AULA>"
    echo "Exemple: $0 A201"
    exit 1
fi
export JUDGEHOST_NAME="judgehost-$1"
docker-compose -f ./jutgehost/docker-compose.yml up
