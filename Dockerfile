FROM daocloud.io/library/centos:6.6

RUN yum -y update && yum -y upgrade

RUN  yum install -y httpd 
EXPOSE 80 

RUN yum install -y php \
                  php-mbstring \
                  php-mysql \
                  php-devel \
                  php-mcrypt \
                  php-bcmath \
                  ImageMagick \
                  memcached

COPY src/ /var/www/html

CMD /usr/sbin/httpd -DFOREGROUND
