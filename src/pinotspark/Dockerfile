# Copied from: https://github.com/apache/incubator-pinot/blob/master/docker/images/pinot/Dockerfile
ARG JAVA_VERSION=11
FROM openjdk:${JAVA_VERSION} AS pinot_build_env

LABEL MAINTAINER=dev@pinot.apache.org

ARG PINOT_BRANCH=release-0.7.1
ARG PINOT_GIT_URL="https://github.com/apache/incubator-pinot.git"
RUN echo "Trying to build Pinot from [ ${PINOT_GIT_URL} ] on branch [ ${PINOT_BRANCH} ] with Kafka version [ ${KAFKA_VERSION} ]"
ENV PINOT_HOME=/opt/pinot
ENV PINOT_BUILD_DIR=/opt/pinot-build

# extra dependency for running launcher
RUN apt-get update && \
    apt-get install -y --no-install-recommends vim wget curl git automake bison flex g++ libboost-all-dev libevent-dev libssl-dev libtool make pkg-config && \
    rm -rf /var/lib/apt/lists/*

# install maven
RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
  && wget https://www-us.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz -P /tmp \
  && tar -xzf /tmp/apache-maven-*.tar.gz -C /usr/share/maven --strip-components=1 \
  && rm -f /tmp/apache-maven-*.tar.gz \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn
ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG /opt/.m2

# install thrift
RUN  wget http://archive.apache.org/dist/thrift/0.12.0/thrift-0.12.0.tar.gz -O /tmp/thrift-0.12.0.tar.gz && \
     tar xfz /tmp/thrift-0.12.0.tar.gz --directory /tmp && \
     base_dir=`pwd` && \
     cd /tmp/thrift-0.12.0 && \
     ./configure --with-cpp=no --with-c_glib=no --with-java=yes --with-python=no --with-ruby=no --with-erlang=no --with-go=no --with-nodejs=no --with-php=no && \
     make install


RUN git clone ${PINOT_GIT_URL} ${PINOT_BUILD_DIR} && \
    cd ${PINOT_BUILD_DIR} && \
    git checkout ${PINOT_BRANCH} && \
    mvn install package -DskipTests -Pbin-dist

RUN cd ${PINOT_BUILD_DIR} && \
    mkdir -p ${PINOT_HOME}/configs && \
    mkdir -p ${PINOT_HOME}/data && \
    cp -r pinot-distribution/target/apache-pinot-*-bin/apache-pinot-*-bin/* ${PINOT_HOME}/. && \
    chmod +x ${PINOT_HOME}/bin/*.sh

FROM bitnami/spark:2.4.6

LABEL MAINTAINER=dev@pinot.apache.org

ENV PINOT_VERSION=0.7.1
ENV PINOT_DISTRIBUTION_DIR=/opt/pinot

VOLUME ["${PINOT_DISTRIBUTION_DIR}/configs", "${PINOT_DISTRIBUTION_DIR}/data"]

COPY --from=pinot_build_env ${PINOT_DISTRIBUTION_DIR} ${PINOT_DISTRIBUTION_DIR}