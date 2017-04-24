FROM ubuntu:16.04

RUN mkdir /opt/stack
WORKDIR /opt/stack

RUN apt-get update
RUN apt-get -y install git python-pip curl

RUN git clone https://github.com/openstack/kuryr-kubernetes

WORKDIR /opt/stack/kuryr-kubernetes/

RUN python setup.py install
RUN pip install kuryr-kubernetes


# wait k8s api server
ADD wait_for.sh /opt/stack/wait_for.sh
RUN chmod +x /opt/stack/wait_for.sh

RUN mkdir /etc/kuryr
COPY kuryr.conf /etc/kuryr/kuryr.conf

CMD ["./run_kuryr.sh"]
