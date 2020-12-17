USUARI="joapuiib"
ORIGEN=""
while [ $# -ge 1 ] ; do

    case $1 in
        -h | --host)
            ORIGEN=$2
            shift
            ;;
        *)
            echo "Opció $1 errònia!"
            ;;
    esac
    shift
done

if [ "X${ORIGEN}" = "X" ] ; then

    echo ""
    echo "Us: $0 -h | --host <hostname>"
    echo ""

    exit 1
fi


mkdir -p /dades/dades/jpuig
CMD_REAL="rsync -avHCR ${USUARI}@${ORIGEN}:vm/JutgeHost /dades/dades/jpuig"
