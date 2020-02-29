FROM amazonlinux:2.0.20191016.0

ARG AWS_VERSION=1.16.306

RUN yum -y install python3-3.7.4-1.amzn2.0.3.x86_64 && \
    pip3 install awscli==${AWS_VERSION} s3cmd python-magic && \
    yum clean all && rm -rf /var/cache/yum

VOLUME /root/.aws
VOLUME /root/.kube
VOLUME /wd
WORKDIR /wd

ENTRYPOINT ["aws"]