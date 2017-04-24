install -o $(whoami) -m 0555 -D $(which kuryr-cni) "/opt/stack/cni/bin/kuryr-cni"
./wait_for.sh
python /opt/stack/kuryr-kubernetes/scripts/run_server.py  --config-file /etc/kuryr/kuryr.conf
