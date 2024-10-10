FROM azul/zulu-openjdk:23-latest

LABEL org.opencontainers.image.authors="Aleyr Lengiac - aleyr7+github@gmail.com"

# This makes debconf use a frontend that expects no interactive input at all,
# preventing it from even trying to access stdin (this avoiding a big red error
# message in console output)
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get upgrade \
  && apt-get install -y curl wget vim \
  && apt-get install -y git sudo

##############################################
# Install Maven
##############################################
# Latest version at this time
ARG MAVEN_VERSION_NUMBER=3.9.9
ARG MAVEN_VERSION=apache-maven-${MAVEN_VERSION_NUMBER}
ARG MAVEN_TARBALL=${MAVEN_VERSION}-bin.tar.gz
ARG MAVEN_INSTALL_DIR=/usr/local/src

#ADD https://dlcdn.apache.org/maven/maven-3/${MAVEN_VERSION_NUMBER}/binaries/${MAVEN_TARBALL} ${MAVEN_INSTALL_DIR}/${MAVEN_TARBALL}
COPY ${MAVEN_TARBALL} ${MAVEN_INSTALL_DIR}/${MAVEN_TARBALL}

RUN cd ${MAVEN_INSTALL_DIR}        \
  &&  tar -xf  "${MAVEN_TARBALL}"  \
  && rm -f "${MAVEN_TARBALL}"      

# Setup MAVEN ENVironment variables
ENV M2_HOME=${MAVEN_INSTALL_DIR}/${MAVEN_VERSION}
ENV PATH=${M2_HOME}/bin:${PATH}
ENV JAVA_BIN=${JAVA_HOME}/bin/java

##############################################
# Install IntelliJ Community Edition IDEA
##############################################
# Latest version at this time
ARG IJ_VERSION=2024.2.3
ARG IJ_TARBALL=ideaIC-${IJ_VERSION}.tar.gz
ARG IJ_EXTRACT=idea-IC-${IJ_VERSION}
ARG IJ_INSTALL_DIR=/opt

#ADD https://download.jetbrains.com/idea/${IJ_TARBALL} ${IJ_INSTALL_DIR}/${IJ_TARBALL}
COPY ${IJ_TARBALL} ${IJ_INSTALL_DIR}/${IJ_TARBALL}

RUN  cd ${IJ_INSTALL_DIR}   \
  && tar -xf  ${IJ_TARBALL} \
  && rm -f ${IJ_TARBALL}

RUN ls /opt | grep idea > /opt/idea_path.txt | export IJ_INSTALL_DIR_NAME=$(cat /opt/idea_path.txt)

ENV IJ_SETUP_SCRIPT_DIR_CNTR=${IJ_INSTALL_DIR}/${IJ_INSTALL_DIR_NAME}/bin

###############################################################
# Removes accessibility warning (known bug) in console log 
# which is annoying to see as a developer when started manually
###############################################################
ENV NO_AT_BRIDGE=1

CMD sh