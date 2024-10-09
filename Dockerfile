FROM aleyr/intellij-ide-base:21-alpine

LABEL org.opencontainers.image.authors="Aleyr Lengiac - aleyr7+github@gmail.com"

# Switch to non-root user 
# The host machine $USER is used, past in via --build-arg 
# in order to persist data across invocations of container.
# Default user is "nobody" if ever no --build-arg is provided.
# However that won't persist the data on host machine after 
# container is terminated so for best experience use the run.sh
# script that does this for you.
ARG USER=desantos      

RUN echo "Will use USER=${USER}"

ENV HOME=/home/${USER}
ENV GROUPNAME=${USER}
ENV USER_ID=1000
ENV GROUP_ID=1000

RUN groupadd --gid ${GROUP_ID} ${GROUPNAME} && \
    useradd -M --gid ${GROUP_ID} $USER && \
    export uid=${USER_ID} gid=${GROUP_ID} && \
    mkdir -p /etc/sudoers.d && \
    echo "${USER}:x:${USER_ID}:${GROUP_ID}:${USER},,,:${HOME}:/bin/bash" >> /etc/passwd && \
    echo "${USER}:x:${USER_ID}:" >> /etc/group && \
    echo "${USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${USER} && \
    chmod 0440 /etc/sudoers.d/${USER} 

##########################################################################
# Need to create IJ directories here and then set persmissions for end
# user or else when bind mounting, they will always be owned by root
##########################################################################

ARG IDEA_TAG=DockerIdeaIC

RUN mkdir -p ${HOME} &&   \
    mkdir -p ${HOME}/.config/JetBrains/${IDEA_TAG} &&   \
    mkdir -p ${HOME}/.local/share/JetBrains/${IDEA_TAG} &&   \
    mkdir -p ${HOME}/.local/share/JetBrains/consentOptions &&   \
    mkdir -p ${HOME}/.java/.userPrefs &&   \
    chown -R ${USER}:${USER} ${HOME} &&   \
    chmod 2764 -R ${HOME}

USER ${USER}
WORKDIR ${HOME}

RUN echo "${IJ_SETUP_SCRIPT_DIR_CNTR}"

#ENTRYPOINT  ["sh", "-c", "${IJ_SETUP_SCRIPT_DIR_CNTR}/idea.sh"]
#CMD sh