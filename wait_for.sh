# get host ip

HOST_IP=$(/sbin/ip route|awk '/default/ { print $3 }')

until curl -o /dev/null -sIf "http://$HOST_IP:8080"; do
  echo -n "."
  sleep 1
done
