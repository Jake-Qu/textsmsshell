# !/bin/bash
canshu=$2
number=$3

function conf-n {
    cd /root/textsmsshell
    curl 'http://www.66ip.cn/nmtq.php?getnum=100&isp=0&anonymoustype=3&start=&ports=&export=&ipaddress=&area=1&proxytype=0&api=66ip' > init_data
    cat init_data | grep "br" | awk '{print $1}'| sed 's/<br//' | head -n $canshu > lastfile
    cat lastfile | while read line
        do
            echo "curl -X POST -x "$line"  https://textbelt.com/text        --data-urlencode phone='$number'        --data-urlencode message='Hello world' -d key=textbelt"
            curl -X POST -x "$line"  https://textbelt.com/text        --data-urlencode phone='''$number'''        --data-urlencode message='Hello world' -d key=textbelt
        done
}

function conf-f {
    cat $canshu | while read line
    do
        echo "curl -X POST -x "$line"  https://textbelt.com/text        --data-urlencode phone='$number'        --data-urlencode message='Hello world' -d key=textbelt"
        curl -X POST -x "$line"  https://textbelt.com/text        --data-urlencode phone='''$number'''        --data-urlencode message='Hello world' -d key=textbelt
    done
}

print_help() {
    echo ""
    echo "  -n)"
    echo "     -n send sms number."
    echo "  -f)"
    echo "     -f use proxy file"
    echo "  For example:"
    echo "  ./main.sh -f /data/list '+8615011111111'"
    exit 0
}

while test -n "$1"; do
    case "$1" in
        -n)
            conf-n
            shift
            ;;
        -f)
            conf-f
            shift
            ;;
        *)
            echo "Unknown argument: $2"
            print_help
            exit 0
            ;;
    esac
    shift
done
