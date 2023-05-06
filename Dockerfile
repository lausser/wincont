FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm-256color

RUN apt-get update -y && \
    apt-get install -y \
    qemu-kvm \
    build-essential \
    libvirt-daemon-system \
    libvirt-dev \
    linux-image-unsigned-5.15.0-71-generic \
    curl \
    net-tools \
    jq && \
    apt-get autoremove -y && \
    apt-get clean
    #linux-image-$(uname -r) \


RUN curl -O https://releases.hashicorp.com/vagrant/2.3.4/vagrant_2.3.4-1_amd64.deb && \
	dpkg -i vagrant_2.3.4-1_amd64.deb && \
	vagrant plugin install vagrant-libvirt && \
	vagrant box add --provider libvirt peru/windows-10-enterprise-x64-eval && \
	vagrant init peru/windows-10-enterprise-x64-eval

COPY Vagrantfile /
COPY startup.sh /

ENTRYPOINT ["/startup.sh"]

CMD ["/bin/bash"]
