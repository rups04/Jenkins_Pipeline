FROM centos
RUN yum install httpd -y
COPY  Hello_World/*  /var/www/html/
EXPOSE 80
CMD /usr/sbin/httpd -DFOREGROUND
