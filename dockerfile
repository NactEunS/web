#基础镜像为官方centos7
FROM centos:7
MAINTAINER salo

ARG PROJECT_NAME

#暂用本地项目
COPY . /usr/local/${PROJECT_NAME}/

#设置工作目录
WORKDIR /usr/local/

#安装wget,下载安装jdk/maven
RUN yum update -y -q && yum install -y -q maven

#设置工作目录
WORKDIR /usr/local/${PROJECT_NAME}/

CMD mvn spring-boot:run
