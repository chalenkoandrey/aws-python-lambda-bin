FROM ubuntu:20.04

USER root
RUN mkdir -p /opt
WORKDIR /tmp
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y \
    && apt-get install -y zip unzip wget tar gzip python3.9 pip python3.9-venv curl

RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
  && python3.9 get-pip.py

RUN cd /opt \
  && curl -LO "https://dl.k8s.io/release/v1.30.3/bin/linux/amd64/kubectl" \
  && chmod +x /opt/kubectl

RUN python3.9 -m venv /tmp

SHELL ["/bin/bash", "-c"]

RUN source /tmp/bin/activate \
  && pip3.9 install awscli \
  && sed -i "1s/.*/\#\!\/var\/lang\/bin\/python/" /tmp/bin/aws \
  && deactivate

RUN cp /tmp/bin/aws /opt
RUN cp -r /tmp/lib/python3.9/site-packages/* /opt
COPY requirements.txt .

RUN pip3.9 install -r requirements.txt -t /opt/python/lib/python3.9/site-packages/

RUN cd /opt \
    && zip --symlinks -r ../kubectl_layer.zip * \
    && echo "/layer.zip is ready" \
    && ls -alh /kubectl_layer.zip;

WORKDIR /
ENTRYPOINT [ "/bin/bash" ]