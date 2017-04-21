FROM ubuntu:16.04

RUN mkdir /opt/stack
WORKDIR /opt/stack

RUN apt-get update
RUN apt-get -y install git python-pip

RUN git clone https://github.com/openstack/kuryr-kubernetes

WORKDIR /opt/stack/kuryr-kubernetes/

RUN python setup.py install
RUN pip install kuryr-kubernetes

RUN echo $(which kuryr-cni)

#RUN mkdir /opt/stack/cni/bin
RUN install -o $(whoami) -m 0555 -D $(which kuryr-cni) "/opt/stack/cni/bin/kuryr-cni"

# wait k8s api server
ADD wait_for.sh /wait_for.sh
RUN chmod +x /wait_for.sh
CMD ["/wait_for.sh"]

RUN mkdir /etc/kuryr
COPY kuryr.conf /etc/kuryr/kuryr.conf

RUN python /opt/stack/kuryr-kubernetes/scripts/run_server.py  --config-file /etc/kuryr/kuryr.conf

