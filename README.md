# Docker for Your Java Developent Environment with IntelliJ

This is an adaptation for Mac OS of the Post http://mvpjava.com/docker-java-development-environment-intellij
and the You Tube Tutorial https://youtu.be/HUj1RbwYXVQ by mvpjava.

+ Note: Only works if your running Docker on a Mac host/VM

Pre-requisites:
- Docker for Mac
- XQuartz configured as per https://gist.github.com/sorny/969fe55d85c9b0035b0109a31cbcb088 instructions

This is meant for Java Developers who want to run their IntelliJ IDEA in a Docker Container.

This image will take the current $USER on the host machine into account so that you
may have access to all IntelliJ directories in the container (*not as root user). 

Also, the bind mount volumes are binded on host to allow the state of IntelliJ to be preserved across re-runs.
So IntelliJ plugins and preferences are preserved as well as maven $HOME/.m2 directory
so you don't have to keep downloading the same artifacts.

You can share your source code with the IntelliJ. Just place you source code in (default location) .
${HOME}/IdeaIC2024.2/IdeaProjects


# How to test if XQuartz is configured correctly

Within the docker_xclock_test directory chmod +x test.sh and the ./test.sh if xclock starts XQuartz is working correctly.


# Base Directory
The image will be uploaded to DockerHub, you can also build the image locally using the build.sh script 
inside docker_context_base_image directory.

# How to start Docker Container
You must execute the ./run.sh script which handles all of this ...

+ $ git clone https://github.com/mvpjava/intelliJ-ce-idea.git
+ $ cd intelliJ-ce-idea
+ $ chmod 754 ./run.sh
+ $ ./run.sh

All Docker images can be found on my DockerHub account under 
+ https://hub.docker.com/repository/docker/aleyr/intellij-ide
+ https://hub.docker.com/repository/docker/aleyr/aleyr/intellij-ide-base


