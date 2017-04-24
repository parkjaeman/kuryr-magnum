# get host ip

HOST_IP=$(/sbin/ip route|awk '/default/ { print $3 }')

echo $HOST_IP
#HOST_IP=172.24.4.6
echo $HOST_IP

until curl -o /dev/null -sIf "http://$HOST_IP:6443"; do
  echo -n "."
  sleep 1
done
