FROM python:3


RUN pip3 install yamllint ansible-lint ansible==2.9.9
RUN	useradd -d /ansible -M -s /bin/bash -U -u 1000 ansible

ADD --chown=1000:1000  . /ansible
WORKDIR /ansible
RUN ansible-galaxy install -r requirements.yml
