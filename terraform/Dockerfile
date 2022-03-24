FROM ubuntu:focal

ARG ssh_prv_key
ARG ssh_pub_key

RUN apt-get update && apt-get install -y openssh-client openssh-server
RUN useradd -m -s /bin/bash -g root -G sudo atcomputing
RUN echo 'atcomputing:atcomputing' | chpasswd
RUN mkdir -p /home/atcomputing/.ssh

RUN echo "$ssh_prv_key" > /home/atcomputing/.ssh/id_rsa && \
    echo "$ssh_pub_key" > /home/atcomputing/.ssh/id_rsa.pub && \
    chmod 600 /home/atcomputing/.ssh/id_rsa && \
    chmod 600 /home/atcomputing/.ssh/id_rsa.pub

RUN echo "Host *\n\tStrictHostKeyChecking no\n" >> /home/atcomputing/.ssh/config
RUN chmod 700 /home/atcomputing/.ssh
RUN chown -R atcomputing:root /home/atcomputing/.ssh

RUN service ssh start
EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]
