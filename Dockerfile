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
                  ImageMagick-devel \
                  memcached \
                  tar \
                  curl 

COPY mcrypt-2.6.8.tar.gz /
WORKDIR /

RUN tar -zxvf mcrypt-2.6.8.tar.gz \ 
        && cd mcrypt-2.6.8 \ 
        && LD_LIBRARY_PATH=/usr/local/lib ./configure \
        && make && make install 

COPY src/ /var/www/html

CMD /usr/sbin/httpd -DFOREGROUND
