ROOT="root"
ROOTPW="rootpw"
QUERY=""

while [ $# -gt 0 ]; do
    case $1 in
        -f)
            QUERY="$QUERY `cat $2`"
            shift
            ;;
        *)
            QUERY="$QUERY $1"
            ;;
    esac
    shift
done

if [ -z "$QUERY" ] ; then 
    docker exec -it jutgeserver_db_1 mysql -u$ROOT -p$ROOTPW
else
    docker exec -it jutgeserver_db_1 mysql -u$ROOT -p$ROOTPW -e "$QUERY"
fi
