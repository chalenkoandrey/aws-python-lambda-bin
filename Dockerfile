FROM ubuntu:24.04

USER root
RUN mkdir -p /opt
WORKDIR /tmp
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y \
  && apt install -y software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa

RUN apt-get update -y \
    && apt-get install -y zip unzip wget tar gzip python3.13 python3.13-venv curl

RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
  && python3.13 get-pip.py

RUN python3.13 -m venv /tmp

SHELL ["/bin/bash", "-c"]

RUN source /tmp/bin/activate \
  && deactivate

RUN cp -r /tmp/lib/python3.13/site-packages/* /opt
COPY requirements.txt .

RUN pip3.13 install -r requirements.txt -t /opt/python/lib/python3.13/site-packages/

RUN cd /opt \
    && zip --symlinks -r ../kubectl_layer.zip * \
    && echo "/layer.zip is ready" \
    && ls -alh /kubectl_layer.zip;

WORKDIR /
ENTRYPOINT [ "/bin/bash" ]